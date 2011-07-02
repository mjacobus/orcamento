require 'test_helper'

class MovimentoTest < ActiveSupport::TestCase
  
  fixtures :movimentos,:usuarios
  
  def setup
    @usuario = Usuario.first
    @movimento = Movimento.first
  end
  
  def test_usuario_id_is_required 
    @movimento.usuario_id = nil
    assert_equal false, @movimento.valid?
    assert_equal @movimento.errors[:usuario_id][0], "Campo obrigatório"
  end
  
  def test_valor_is_required
    @movimento.reload
    @movimento.valor = nil
    assert_equal false, @movimento.valid?
    assert_equal @movimento.errors[:valor][0], "Campo obrigatório"
  end
  
  def test_tipo_is_required
    @movimento.reload
    @movimento.tipo = nil
    assert_equal false, @movimento.valid?
    assert_equal @movimento.errors[:tipo][0], "Valor inválido"
  end
  
  def test_descricao_is_required
    @movimento.reload
    @movimento.descricao = nil
    assert_equal false, @movimento.valid?
    assert_equal @movimento.errors[:descricao][0], "Campo obrigatório"
  end
  
  def test_is_valid
    @movimento.reload
    assert_equal true, @movimento.valid?
  end
  
end
