; 1. Реалізація group-pairs
 (defun group-pairs (lst)
  (cond
    ((null lst) nil) ; Якщо список порожній, повернути порожній список.
    ((null (cdr lst)) (list (list (car lst)))) ; Якщо залишився один елемент, помістити його в окремий список.
    (t (cons (list (car lst) (cadr lst)) ; Групуємо перші два елементи у підсписок.
         (group-pairs (cddr lst)))))) 

; 2. Реалізація list-set-union
(defun list-set-union (set1 set2)
  (cond
    ((null set1) set2) ; Якщо перший список порожній, повернути другий список.
    ((member (car set1) set2) ; Якщо перший елемент set1 вже є в set2...
     (list-set-union (cdr set1) set2)) ; ...рекурсивно обробляємо решту set1.
    (t (cons (car set1) ; Додаємо елемент з set1 до об'єднання.
             (list-set-union (cdr set1) set2)))))

; 3. Функції тестування
(defun check-function (name func input expected)
  "Виконує тестування функції `func` з вхідними даними `input` та очікуваним результатом `expected`.
  Виводить повідомлення про успішність тесту."
  (format t "~:[FAILED~;passed~]... ~a~%"
          (equal (apply func input) expected) ; Використовуємо `apply` для передачі списку аргументів.
          name))

 (defun test-group-pairs ()
  "Тестує функцію `group-pairs`."
  ;; Успішні тести
  (check-function "group-pairs test 1" #'group-pairs '((a b c d e f g)) '((A B) (C D) (E F) (G)))
  (check-function "group-pairs test 2" #'group-pairs '((1 2 3 4 5)) '((1 2) (3 4) (5)))
  ;; Невдалий тест
  (check-function "group-pairs test 3 (FAIL)" #'group-pairs '((1 2 3 4)) '((1 2) (3 4) (5))))

(defun test-list-set-union ()
  "Тестує функцію `list-set-union`."
  ;; Успішні тести
  (check-function "list-set-union test 1" #'list-set-union '((1 2 3) (2 3 4)) '(1 2 3 4))
  (check-function "list-set-union test 2" #'list-set-union '((a b c) (c d e)) '(A B C D E))
  ;; Невдалий тест
  (check-function "list-set-union test 3 (FAIL)" #'list-set-union '((1 2) (2 3)) '(1 2 3 4)))

; 4. Функція run-tests
(defun run-tests ()
  "Запускає всі тести для перевірки функцій."
  (format t "Testing group-pairs...~%")
  (test-group-pairs)
  (format t "Testing list-set-union...~%")
  (test-list-set-union))