#include <stdio.h>
#include <stdlib.h>

double *input_matrix(int *r, int *c, const char *name);
int matrix_multiply(double *m1, int m1_rows, int m1_columns, double *m2, int m2_rows, int m2_columns, double *m3);
void output_matrix(double *m, int rows, int columns);

int main(void) {
    double *m1, *m2, *m3;
    int m1_rows, m1_columns, m2_rows, m2_columns;

    // Input matrices
    if (((m1 = input_matrix(&m1_rows, &m1_columns, "Matrix 1")) != NULL) &&
        ((m2 = input_matrix(&m2_rows, &m2_columns, "Matrix 2")) != NULL) &&
        ((m3 = malloc(m1_rows * m2_columns * sizeof(double))) != NULL)) {

        // Display input matrices
        printf("Matrix 1\n");
        output_matrix(m1, m1_rows, m1_columns);

        printf("Matrix 2\n");
        output_matrix(m2, m2_rows, m2_columns);

        // Matrix multiplication
        if (matrix_multiply(m1, m1_rows, m1_columns, m2, m2_rows, m2_columns, m3)) {

            // Display the result
            printf("Product\n");
            output_matrix(m3, m1_rows, m2_columns);

            free(m1);
            free(m2);
            free(m3);
            return 0;
        } else {
            printf("Error in dimensions\n");
        }
    } else {
        printf("Error allocating memory\n");
    }

    free(m1);
    free(m2);
    free(m3);
    return -2;
}

double *input_matrix(int *r, int *c, const char *name) {
    printf("Enter %s rows and columns: ", name);
    scanf("%d %d", r, c);

    double *m = (double *)malloc((*r) * (*c) * sizeof(double));

    printf("Enter %s elements: ", name);
    for (int i = 0; i < *r; i++) {
        for (int j = 0; j < *c; j++) {
            scanf("%lf", &m[i * (*c) + j]);
        }
    }

    return m;
}

int matrix_multiply(double *m1, int m1_rows, int m1_columns, double *m2, int m2_rows, int m2_columns, double *m3) {
    if (m1_columns != m2_rows) {
        return 0;
    }

    for (int i = 0; i < m1_rows; i++) {
        for (int j = 0; j < m2_columns; j++) {
            double sum = 0;
            for (int k = 0; k < m2_rows; k++) {
                sum += m1[i * m1_columns + k] * m2[k * m2_columns + j];
            }
            m3[i * m2_columns + j] = sum;
        }
    }
    return 1;
}

void output_matrix(double *m, int rows, int columns) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            printf("%.2lf ", m[i * columns + j]);
        }
        printf("\n");
    }
}
