class MovimentosController < ApplicationController
  # GET /movimentos
  # GET /movimentos.xml
  def index

    q = Movimento.includes(:usuario).order(:data_prevista, 'tipo DESC', :valor)

    #usuario
    q = q.where("usuario_id = ?", params[:usuario_id]) if params[:usuario_id]
    # tipo
    q = q.where("tipo= ?", params[:tipo]) if params[:tipo]
    # realizado
    if (params[:realizado])
      if params[:realizado] == "true"
        q = q.where('data_realizacao IS NOT NULL')
      else
        q = q.where('data_realizacao IS NULL')
      end
    end

    if !params[:all]
      if !params[:ano] && !params[:mes]
        d = Time.now
        params[:ano] = d.year
        params[:mes] = d.month
      end

      # data prevista
      if params[:data_prevista_de] && params[:data_prevista_ate]
        q = q.where(:data_prevista => params[:data_prevista_de]..params[:data_prevista_ate])
      end

      # data realizada
      if params[:data_realizacao_de] && params[:data_realizacao_ate]
        q = q.where(:data_realizacao => params[:data_realizacao_de]..params[:data_realizacao_ate])
      end

      # data realizada
      if params[:ano] && params[:mes]
        ini_date = Date.new(params[:ano].to_i, params[:mes].to_i)
      next_month = (ini_date+42)
      end_date = Date.new(next_month.year,next_month.month) -1
      q = q.where(:data_prevista => ini_date.to_s..end_date.to_s)
      end
    end

    @movimentos = q

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
