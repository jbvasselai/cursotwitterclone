CREATE DATABASE IF NOT EXISTS twitter_clone;
USE twitter_clone;

CREATE TABLE IF NOT EXISTS usuarios (
  id       INT AUTO_INCREMENT PRIMARY KEY,
  usuario  VARCHAR(50)  NOT NULL,
  email    VARCHAR(100) NOT NULL,
  senha    VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tweet (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario     INT           NOT NULL,
  tweet          TEXT          NOT NULL,
  data_inclusao  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_tweet_usuario (id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS usuarios_seguidores (
  id_usuario_seguidor  INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario           INT NOT NULL,
  seguindo_id_usuario INT NOT NULL,
  UNIQUE KEY uniq_seguidor (id_usuario, seguindo_id_usuario),
  INDEX idx_seguidor_seguindo (seguindo_id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Seed user: usuario=admin senha=admin
INSERT INTO usuarios (usuario, email, senha)
VALUES ('admin', 'admin@example.com', '21232f297a57a5a743894a0e4a801fc3')
ON DUPLICATE KEY UPDATE usuario = usuario;
