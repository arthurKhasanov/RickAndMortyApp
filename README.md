# rick_and_morty_app

A new Flutter project.

## Getting Started

Учебный проект из курса "Изучаем Flutter" по разделу Чистая Архитектура

# Введение:

Архитектура приложения - это набор методов и шаблонов, которые позволяют разработчикам создавать структурированные, что позволяет быстро делать рефакторинг или вносить новые изменения в приложения. Смысл архитектуры привнести легкость изменяемости, развертывания приложения, управление сложностью приложения.

Чистая архитектура - паттерн для проектирования архитектуры приложения в целом.

Все архитектурные паттерны имеют общую задачу - построение неких слоев приложения и эти слои разделяют определенные обязанности между собой. Автор Роберт Мартин также заметил что все архитектурные паттерны стремятся отделить Бизнес-логику от других слоев приложения. 

Что дает нам архитектура:

Независимоть от фреймворка
Архитектура не зависит от существования какой-либо библиотеки. Это позволяет использовать фреймворк в качестве инструмента, вместо того чтобы втискивать свою систему в рамки его ограничений.

Независимость от UI
Пользовательский интерфейс можно легко изменить, не меняя остальную систему. Например, веб-интерфейс можно изменить на консольный, не меняя систему.

Независимость от базы данных
Можно заменить SQL на MongoDB. Бизнес система не связана с базой данных.

Независимость от какого-либо внешнего сервера
По факту бизнес правила начего не знают о внешнем мире.

Тестируемость
Бизнес правила могут быть тротестированы без пользовательского интерфейса, базы данных, веб-сервера или любого внешнего сервера.


Образная диаграмма: 

Внешний слой
             _______________________________________________________________ ⬇
             Devises, Web, UI, DB, External Interfaces                           - Внешний слой - слой фреймворков
             _______________________________________________________________ ⬇
             _______________________________________________________________ ⬇
             Controllers, Presenters, Repositories                               - Интерфейс адапторы - адапторы которыепреобразуют данные полученные из бд, или json в формат 
             _______________________________________________________________ ⬇    удобный для Use case и Entities
             _______________________________________________________________ ⬇
             Use Cases                                                           - Методы использования или сценарии, так же их называют интеракторами, эти методы организовывают  
             _______________________________________________________________ ⬇    поток данных в Entities и из них. В этом слое находится логика приложения
             _______________________________________________________________ ⬇
             Entities                                                            - Сущности, Бизнес-логика приложения
             _______________________________________________________________ 
Внутренний слой


Внешний слой представляет конкретные механизмы для определенной платформы. 
Чем дальше в глубь, тем слой более обстрактный и независимый. Центральный круг, наиболее обстрактный и содержит бизнес-логику приложения

В диаграмме описаны два ключевых правила:

Dependancy rule -  зависимости в архитектуре могут указывать только вовнутрь, ничто из внутреннего слоя не может знать о внешнем слое или указывать на него.
Таким образом это правило позволяет строить такие системы, которые легко поддерживать, потому что изменение во внешних слоях не затронут внутренние слои. 

Abstraction rule - по мере продвижения вглубь слоев, каждый слой стаковится более обстрактным, таким образом всешний слой содержит детали реализации, а внутренний наиболее общим - обстрактным.


Так же Чистая Архитектура содержить SOLID принципы, которые помогают проектиовать слои: 

S - Single Responsibility Principle 
    Принцип единственной ответственности: Каждый элемент, который мы создаем, должен обладать своей уникальной функцией, у него не должно быть их несколько.
O - Open/Closed Principle
    Принцип открытости/закрытости: Компоненты должны бить открыты для расширения и закрыты для изменения. Мы должны иметь возможность расширять поведение компонента с одной стороны, но с другой стороны он должен быть закрыт для изменения.
L - Liskov Substitution Principle 
    Принцип подстановки Лисков: Если у нас есть класс одного типа и  какие-либо подклассы этого класса, то мы должны иметь возможность представить использование базового класса с помощью подкласса, не нарушая работу приложения. 
I - Interface Segregation Principle
    Принцип разделения интерфейсов: Лучше иметь много маленьких интерфейсов, чем один большой, чтобы класс не реализовывал методы, которые ему не нужны.
D - Dependency Inversion Principle
    Принцип инверсии зависимотей: Компоненты должны зависеть от абстракций, а не от конкретных реализаций. Так же модули более высокого уровня, не должны зависеть от модулей более низкого уровня.


Горизонтальная схема:


            Presentation layer          |       Domain layer        |    Data layer
                                        |                           |
                                        |                           |
                                        |                           |
                                        |           ___________     |
                               |-----------------> | Interface |    |
                               |        |          |___________|    |
      ____          ___________|_       |       _________⬆_       |        _______________         ______
✅-->|    |  ----> |            |   ----------> | Use Cases |   ----------> |               | ----> |      | <---> 💿
     |    |        |            |       |       |___________|       |       |               |       | DB   |
     | UI |        | Presenter  |       |        _____⬆_____       |       |   Repository  |       |      |
🙂<--|    |  <---- |            |       |        | Entities  |  <---------- |               | <---- | Web  | <---> 💭
     |____|        |____________|       |        |___________|      |       |_______________|       |______|
                                        |                           |
                                        |                           |

1) Cобытие пользователя идет в Presenter
2) Presenter передает событие в Use Cases 
3) Use Cases делает запрос в Repository
4) Repository получает данные либо с базы данных, либо с бэкэнда
5) Repository в свою очередь создает Entities на основе полученных данных
6) Entities передает данные в Use Cases, а он на основе этих данных и своей логики получает результат который передает в Presenter.
7) Presenter отображает результат на UI.

Вертикальные пунктирные линии представляют собой переход между слоями. Они представляют собой два запроса: один для запроса, другой для ответа.
Например, предположим, что нам нужно обратиться из Use Cases в Presenter, однако это обращение должно быть не прямым, чтобы не нарушать правило Зависимости. 
Таким образом Use Cases вызывают Interface на своем уровне, а Presenter своего уровня должен реализовать его. Чтобы зависимость была направлена в сторону обратную потоку данных, применяется принцип Dependency Inversion в SOLID. То есть, вместо того, чтобы Use Cases зависил от Presenter, он зависит от Interface на своем уровне, а Presenter должен его реализовать.

