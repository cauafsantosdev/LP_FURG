#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct {
    char name[50];
    int id;
    double price;
} Product;

typedef struct node {
    Product product;
    struct node* next;
} Node;

int lastID = 0;

Node* insert(Node* list) {
    Product p;
    printf("Nome do produto: ");
    getchar();
    fgets(p.name, sizeof(p.name), stdin);
    p.name[strcspn(p.name, "\n")] = '\0';

    printf("Preço: ");
    if (scanf("%lf", &p.price) != 1) {
        printf("Preço inválido!\n");
        while (getchar() != '\n');
        return list;
    }

    p.id = lastID++;

    Node* new = (Node*) malloc(sizeof(Node));
    if (!new) {
        printf("Erro de alocação!\n");
        exit(1);
    }

    new->product = p;
    new->next = NULL;

    if (!list){ 
        return new;
    }

    Node* element = list;
    while (element->next) {
        element = element->next;
    }
    element->next = new;

    return list;
}

void print_products(Node* list) {
    if (!list) {
        printf("Lista vazia\n");
        return;
    };

    Node* element = list;
    while (element) {
        printf("\nProduto:\n");
        printf("ID: %d\n", element->product.id);
        printf("Nome: %s\n", element->product.name);
        printf("Preço: R$ %.2lf\n", element->product.price);
        element = element->next;
    }
}

void search(Node* list, const char* searching_name) {
    Node* element = list;
    while (element) {
        if (strcmp(element->product.name, searching_name) == 0) {
            printf("\nProduto encontrado:\n");
            printf("ID: %d\n", element->product.id);
            printf("Nome: %s\n", element->product.name);
            printf("Preço: R$ %.2lf\n", element->product.price);
            return;
        }
        element = element->next;
    }
    printf("Produto \"%s\" não encontrado.\n", searching_name);
}

void free_memory(Node* list) {
    Node* element = list;
    while (element) {
        Node* temp = element;
        element = element->next;
        free(temp);
    }
}

int main() {
    Node* list = NULL;
    int option;

    do {
        printf("\n==== MENU ====\n");
        printf("1. Adicionar produto\n");
        printf("2. Exibir todos os produtos\n");
        printf("3. Buscar produto por nome\n");
        printf("4. Sair\n");
        printf("Escolha: ");
        
        if (scanf("%d", &option) != 1) {
            printf("Entrada inválida! Digite um número.\n");
            while (getchar() != '\n');
            continue;
        }

        switch (option) {
            case 1:
                list = insert(list);
                break;
            case 2:
                print_products(list);
                break;
            case 3: {
                char searching_name[50];
                getchar();
                printf("Digite o nome do produto a buscar: ");
                fgets(searching_name, sizeof(searching_name), stdin);
                searching_name[strcspn(searching_name, "\n")] = '\0';
                search(list, searching_name);
                break;
            }
            case 4:
                free_memory(list);
                printf("Memória liberada. Encerrando...\n");
                break;
            default:
                printf("Opção inválida!\n");
        }
    } while (option != 4);

    return 0;
}