require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  
  fixtures :usuarios,:movimentos
  
  def setup
    @usuario = Usuario.first
  end
  
  def test_email_must_be_valid
    emails = {
      "um@example.com" => true,
      "um@example.com.br" => true,
      "noemail" => false,
      "um.dois@email.com" => true,
      "um.@email.com.br.br" => false,
      "a@@email.com" => false,
      "x*email.com" => false
      }
      
      emails.each do |email,valid|
        @usuario.email = email
        assert_equal valid, @usuario.valid?
        if (!valid)
          assert_equal @usuario.errors[:email][0], "email inválido"
        end 
      end
  end
  
  def test_email_must_be_unique
    @usuario.reload
    novo_usuario = Usuario.new
    novo_usuario.email = @usuario.email
    novo_usuario.nome = @usuario.nome
    novo_usuario.senha_salt = @usuario.senha_salt
    novo_usuario.senha_hash = @usuario.senha_hash
    assert_equal novo_usuario.valid?, false
    assert_equal novo_usuario.errors[:email][0], "já está em uso"
  end
  
  def test_email_is_required
    @usuario.email = nil
    assert_equal false, @usuario.valid?
    assert_equal @usuario.errors[:email][0], "não pode ficar em branco"
  end
  
  def test_nome_is_required
    @usuario.reload
    @usuario.nome = nil
    assert_equal false, @usuario.valid?
    assert_equal @usuario.errors[:nome][0], "não pode ficar em branco"
  end
  
  def test_usuario_cannot_be_deleted_if_has_movimentos
    movimento = Movimento.create(:valor => 10,:descricao => "teste",
      :data_prevista => "2011-01-01", :tipo => 1, :usuario_id => @usuario.id)
    assert_equal true, movimento.valid?  
    @usuario.reload
    assert_equal true, @usuario.movimentos.count() > 0
    assert_equal false, @usuario.destroy
    assert_equal true, movimento.destroy != false
    assert_equal true, @usuario.destroy != false
  end


end
