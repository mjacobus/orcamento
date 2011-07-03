class Usuario < ActiveRecord::Base
  # nao existem na tabela
  attr_accessor :senha, :senha_confirmacao

  before_save :encrypt_password
  before_destroy :verify_movimentos

  validates :email, :presence => true,
    :uniqueness => {:case_sensitive => false}
  validates :senha, :presence => {:on => :create}
  validates :nome, :presence => true

  validate :validate_email
  validate :validate_senha
  def validate_email
    if email.present?
      if !email.match(/^[\da-zAZ_\.]+@[a-zAZ_-]+(\.[a-z]{2,3}){1,2}$/)
        errors.add(:email,'email inválido')
      end
    end
  end

  def validate_senha
    if senha.present?
      if senha != senha_confirmacao
        errors.add(:senha, "as senhas não conferem")
      elsif senha.length < 8
        errors.add(:senha, "deve ter pelo menos 8 caractéres")
      end

    end
  end

  def encrypt_password
    if senha.present?
      self.senha_salt = BCrypt::Engine.generate_salt
      self.senha_hash = BCrypt::Engine.hash_secret(senha, senha_salt)
    end
  end

  def self.authenticate(email, senha)
    usuario = find_by_email(email)
    if usuario && usuario.senha_hash == BCrypt::Engine.hash_secret(senha, usuario.senha_salt)
    usuario
    else
    nil
    end
  end

  has_many :movimentos

  def verify_movimentos
    # só se exclui usuário que não tem movimentos
    movimentos.count() == 0
  end
end
