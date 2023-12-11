package Model;
public class EnderecoEntrega {
    private int id;
    private int clienteId;
    private String cep;
    private String logradouro;
    private int numero;
    private String complemento;
    private String cidade;
    private String estado;

    // Construtores, getters e setters

    // Exemplo de construtor
    public EnderecoEntrega(int clienteId, String cep, String logradouro, int numero, String complemento, String cidade, String estado) {
        this.clienteId = clienteId;
        this.cep = cep;
        this.logradouro = logradouro;
        this.numero = numero;
        this.complemento = complemento;
        this.cidade = cidade;
        this.estado = estado;
    }

    // Outros métodos, se necessário
}
