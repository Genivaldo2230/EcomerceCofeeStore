package br.com.gymcontrol.Model;

public class Endereco {
    private int id;
    private String cep;
    private String logradouro;
    private int numero;
    private String complemento;
    private String bairro;
    private String cidade;
    private String uf;
    private boolean enderecoAtivo;
    private int idCliente; // Referência ao cliente associado


    public Endereco() {
    }

    public Endereco(int id, String cep, String logradouro, int numero, String complemento, String bairro, String cidade, String uf, boolean enderecoAtivo, int idCliente) {
        this.id = id;
        this.cep = cep;
        this.logradouro = logradouro;
        this.numero = numero;
        this.complemento = complemento;
        this.bairro = bairro;
        this.cidade = cidade;
        this.uf = uf;
        this.enderecoAtivo = enderecoAtivo;
        this.idCliente = idCliente;
    }

    public Endereco(String cep, String logradouro, int numero, String complemento, String bairro, String cidade, String uf) {
        this.cep = cep;
        this.logradouro = logradouro;
        this.numero = numero;
        this.complemento = complemento;
        this.bairro = bairro;
        this.cidade = cidade;
        this.uf = uf;
    }

    // Getter e Setter para 'id'
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter e Setter para 'cep'
    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    // Getter e Setter para 'logradouro'
    public String getLogradouro() {
        return logradouro;
    }

    public void setLogradouro(String logradouro) {
        this.logradouro = logradouro;
    }

    // Getter e Setter para 'numero'
    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    // Getter e Setter para 'complemento'
    public String getComplemento() {
        return complemento;
    }

    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }

    // Getter e Setter para 'bairro'
    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    // Getter e Setter para 'cidade'
    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    // Getter e Setter para 'uf'
    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }

    // Getter e Setter para 'enderecoAtivo'
    public boolean isEnderecoAtivo() {
        return enderecoAtivo;
    }

    public void setEnderecoAtivo(boolean enderecoAtivo) {
        this.enderecoAtivo = enderecoAtivo;
    }

    // Getter e Setter para 'idCliente'
    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }
}
