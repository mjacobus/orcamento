class MovimentosController < ApplicationController
  # GET /movimentos
  # GET /movimentos.xml
  def index

    q = Movimento.includes(:usuario).order(:data_prevista, 'tipo DESC', :valor)
    w = ["1 = 1"]
    p = {}

    # usuario
    if params[:usuario_id]
      w << "usuario_id = :usuario_id"
      p[:usuario_id] = params[:usuario_id]
    end

    # tipo
    if params[:tipo]
      w << "(tipo = :tipo)"
      p[:tipo] = params[:tipo]
    end

    if !params[:all]
      if !params[:ano] && !params[:mes]
        d = Time.now
        params[:ano] = d.year
        params[:mes] = d.month
      end

      # data realizada
      ini_date = Date.new(params[:ano].to_i, params[:mes].to_i)
      if params[:ano] && params[:mes]
        next_month = (ini_date+42)
        end_date = Date.new(next_month.year,next_month.month) -1
        
        w << "data_prevista BETWEEN :ini_date AND :end_date"
        p[:ini_date] = ini_date
        p[:end_date] = end_date
      end

      # realizado
      pendente = false
      if (params[:realizado])
        if params[:realizado] == "true"
          w << "data_realizacao IS NOT NULL"
        else
          w << "data_realizacao IS NULL"
          pendente = true
        end
      end
    end
    
    w = "(#{w.join(" AND ")})"
        
    if (pendente) 
      orw = ["data_realizacao IS NULL AND data_prevista <= :ini_date"] 
      if p[:usuario_id]
        orw << "usuario_id = :usuario_id"
      end
      w << " OR (#{orw.join(' AND ')})"
    end
    
    @movimentos = q.where(w,p)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movimentos }
    end
  end

  # GET /movimentos/1
  # GET /movimentos/1.xml
  def show
    @movimento = Movimento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movimento }
    end
  end

  # GET /movimentos/new
  # GET /movimentos/new.xml
  def new
    @movimento = Movimento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movimento }
    end
  end

  # GET /movimentos/1/edit
  def edit
    @movimento = Movimento.find(params[:id])
  end

  # POST /movimentos
  # POST /movimentos.xml
  def create
    @movimento = Movimento.new(params[:movimento])

    respond_to do |format|
      if @movimento.save
        format.html { redirect_to(@movimento, :notice => 'Movimento criado com sucesso.') }
        format.xml  { render :xml => @movimento, :status => :created, :location => @movimento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movimento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movimentos/1
  # PUT /movimentos/1.xml
  def update
    @movimento = Movimento.find(params[:id])

    respond_to do |format|
      if @movimento.update_attributes(params[:movimento])
        format.html { redirect_to(@movimento, :notice => 'Movimento atualizado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movimento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movimentos/1
  # DELETE /movimentos/1.xml
  def destroy
    @movimento = Movimento.find(params[:id])
    success = @movimento.destroy

    message = success ? "Movimento excluído com sucesso." : "Erro ao excluir movimento"
    messageType = success ? :notice : :alert

    respond_to do |format|
      format.html { redirect_to(movimentos_url,messageType => message) }
      format.xml  { head :ok }
    end
  end

  def pagos
    redirect_to :action => :index,:realizado => "true"
  end

  def pendentes
    redirect_to :action => :index,:realizado => "false"
  end
end
