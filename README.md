На стартовом экране находится кнопка «Начать тренировку».

1. При нажатии начинается тренировка, которая состоит из 10 вопросов.
2. Каждый вопрос состоит из предложения перевести с русского на английский одно из следующих слов: малина (211138), яблоко (226138), груша (177344), абрикос (196957), виноград
(224324), грейпфрут (89785), слива (79639), мандарин (173148), ананас (136709), кокос (158582), киви (92590), вишня (135793), банан (68068), авокадо (64441), клубника (46290), арбуз (128173), папайя (51254), лимон (55112), дыня (222435)
3. При старте тренировки вы можете загрузить информацию по всем словам, используя API нашего словаря: *URL_API* — в meaningIds передаём через запятую идентификаторы слов (указаны выше в скобках), а width — ширина экрана устройства, на котором запущено приложение. В ответе есть слово, перевод, аудио файл произношения, url для скачивания картинки, а так же альтернативы, которые вы должны использовать, когда предлагаем пользователю четыре варианта ответа.
4. Тренировка состоит из 10 упражнений, для каждого упражнения выбираем случайным образом слово одно из списка, при этом в рамках тренировки оно не должно повторяться.
5. На экране мы показываем русское слово и 4 варианта английского перевода: *URL*. Сверху прогресс­бар показывает прогресс по тренировке (заполняется 1/10 после каждого ответа и переходе к следующему слову).
6. Если выбирается правильный ответ, слово подсвечивается зелёным, если неверный, то подсвечивается красным.
7. В любом случае после ответа мы показываем карточку слова , и кнопка Дальше, при нажатии на которую, переходим на следующее слово.
8. Переход между карточками и упражнениями делаем с помощью анимации, когда весь экран (кроме верхнего прогресс­бара) улетает влево.

В конце тренировки мы показываем, сколько слов правильно ответ пользователь. Кнопка Повторить — запускает новую тренировку повторно.
