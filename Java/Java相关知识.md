# Java相关知识

- [Java相关知识](#java相关知识)
  - [重写](#重写)
  - [重载](#重载)
    - [重载和重写的区别](#重载和重写的区别)
  - [线程、进程和任务](#线程进程和任务)
    - [进程](#进程)
      - [优点](#优点)
      - [缺点](#缺点)
    - [线程](#线程)
      - [优先级](#优先级)
    - [进程通信](#进程通信)
  - [内存模型](#内存模型)
    - [指令重排序](#指令重排序)
    - [缓存一致性问题](#缓存一致性问题)
    - [常见通信机制通信机制](#常见通信机制通信机制)
    - [线程通信和同步](#线程通信和同步)
    - [内存间交互操作](#内存间交互操作)
    - [对八种操作的规则](#对八种操作的规则)
    - [可见性、有序性和原子性](#可见性有序性和原子性)
      - [原子性](#原子性)
      - [可见性](#可见性)
      - [有序性](#有序性)
  - [生命周期](#生命周期)
    - [动态绑定](#动态绑定)
  - [理解按值传递](#理解按值传递)
  - [协变](#协变)
    - [数组协变](#数组协变)
  - [逆变](#逆变)
  - [运行期类型检查](#运行期类型检查)
  - [类加载器](#类加载器)
  - [实体类](#实体类)
  - [AOP 面向切面编程](#aop-面向切面编程)
  - [前缀\\中缀\\后缀表达试](#前缀中缀后缀表达试)
  - [Java 自动装箱和拆箱机制](#java-自动装箱和拆箱机制)
    - [装箱](#装箱)
    - [拆箱](#拆箱)
  - [注解](#注解)
  - [java 垃圾回收机制、弱\\强引用](#java-垃圾回收机制弱强引用)
    - [@NonNull](#nonnull)
    - [案例](#案例)
      - [Bean的校验框架的注解](#bean的校验框架的注解)

## 重写

> [Java 重写时应当遵守的 11 条规则](https://ost.51cto.com/posts/3678)
> [菜鸟](https://www.runoob.com/java/java-override-overload.html)

重写的目的在于根据对象的类型不同而表现出多态。

- 只能重写继承过来的方法
  意味着，只能重写那些被 public、protected 或者 default 修饰的方法，private、final、static修饰的方法无法被重写
- 重写的方法必须有相同的参数列表(类型和个数一致)，必须返回相同的类型/或子类型
- 重写的方法不能使用限制等级更严格的权限修饰符
  - 如果被重写的方法是 default，那么重写的方法可以是 default、protected 或者 public。
  - 如果被重写的方法是 protected，那么重写的方法只能是 protected 或者 public。
  - 如果被重写的方法是 public， 那么重写的方法就只能是 public。
- 重写后的方法不能抛出比父类中更高级别的异常
- 可以在子类中通过 super 关键字来调用父类中被重写的方法
- 构造方法不能被重写
- 如果一个类继承了抽象类，抽象类中的抽象方法必须在子类中被重写
- synchronized 关键字对重写规则没有任何影响
  synchronized 关键字用于在多线程环境中获取和释放监听对象，因此它对重写规则没有任何影响，这就意味着 synchronized 方法可以去重写一个非同步方法。
- strictfp关键字对重写规则没有任何影响

## 重载

指的是在一个类中定义多个同名方法，但这些方法的参数类型、参数数量或者参数顺序不同，以便用相同的方法名实现不同的操作。在Java中，方法重载是一种静态多态性的实现方式，它允许在编译时根据参数类型来选择调用哪个方法。

### 重载和重写的区别

- 定义位置：方法重载定义在同一个类中，而方法重写定义在父类和子类之间。
- 参数列表：方法重载中方法名相同，但参数列表必须不同，包括参数个数、类型或顺序的不同；方法重写中方法名相同，但参数列表必须完全一样。
- 返回值类型：方法重载与返回值类型无关，只与参数列表有关；方法重写的返回值类型必须相同或为其子类。
- 功能实现：方法重载是在同一个类中定义多个同名方法，可以有不同的功能实现；方法重写是子类对父类的方法进行重新实现，实现方式不同但功能要保持一致。

```java
public class OverloadDemo {
    public void print(String message) {
        System.out.println(message);
    }

    public void print(int number) {
        System.out.println(number);
    }

    public void print(String message, int number) {
        System.out.println(message + " " + number);
    }
}

```

## 线程、进程和任务

### 进程

- 资源分配的最小单位,担当分配系统资源（CPU时间、内存等）的基本单位
- 两个进程想通信，必须通过一个中间代理来实现
- 进程只能操作子进程

#### 优点

- （1）顺序程序的特点：具有封闭性和可再现性；
- （2）程序的并发执行和资源共享。多道程序设计出现后，实现了程序的并发执行和资源共享，提高了系统的效率和系统的资源利用率。

#### 缺点

- 操作系统调度切换多个线程要比切换调度进程在速度上快的多
- 进程间内存无法共享，通讯也比较麻烦
- 在创建或撤消进程时，由于系统都要为之分配和回收资源开销大

### 线程

- 一个标准的线程有线程ID、当前指令指针(PC),寄存器集合和堆栈组成
- 与同属一个进程的其他线程共享进程所拥有的全部资源
- 线程有就绪、阻塞和运行三种基本状态  
- 同一个进程的线程之间可以直接交流
- 一个线程可以控制和操作同一进程里的其他线程

#### 优先级

- 每一个 Java 线程都有一个优先级，这样有助于操作系统确定线程的调度顺序。
- Java 线程的优先级是一个整数，其取值范围是 1 （Thread.MIN_PRIORITY ） - 10 （Thread.MAX_PRIORITY ）。
- 默认情况下，每一个线程都会分配一个优先级 NORM_PRIORITY（5）。
- 具有较高优先级的线程对程序更重要，并且应该在低优先级的线程之前分配处理器资源。但是，线程优先级不能保证线程执行的顺序，而且非常依赖于平台

### 进程通信

## 内存模型

> [java并发编程——内存模型](https://www.jianshu.com/p/b1f7dce224f7)

- 在java内存模型中，也会存在缓存一致性问题和指令重排序的问题

### 指令重排序

一般来说，处理器为了提高程序运行效率，可能会对输入代码进行优化，它不保证程序中各个语句的执行先后顺序同代码中的顺序一致
，但是它会保证程序最终执行结果和代码顺序执行的结果是一致的。重排序不会影响单个线程内程序执行的结果

### 缓存一致性问题

> [java并发编程之缓存一致性问题](https://blog.csdn.net/zl18603543572/article/details/89289186)
<https://blog.csdn.net/weixin_42073629/article/details/104731312>
内存和缓存数据如何一致

### 常见通信机制通信机制

- 共享内存：线程之间共享程序的公共状态，线程之间通过写-读内存中的公共状态来隐式进行通信。Java使用的
 -消息传递：线程之间没有公共状态，线程之间必须通过明确的发送消息来显式进行通信。

### 线程通信和同步

- 线程通信：是指线程之间以何种机制来交换信息，在命令式编程中，线程之间的通信机制有两种：共享内存和消息传递。
- 线程同步：是指程序用于控制不同线程之间操作发生相对顺序的机制。在Java中，可以通过volatile，synchronized, 锁等方式实现同步。

### 内存间交互操作

关于主内存与工作内存之间的具体交互协议，即一个变量如何从主内存拷贝到工作内存、如何从工作内存同步到主内存之间的实现细节，Java内存模型定义了以下八种操作来完成：

- lock（锁定）：作用于主内存的变量，把一个变量标识为一条线程独占状态。
- unlock（解锁）：作用于主内存变量，把一个处于锁定状态的变量释放出来，释放后的变量才可以被其他线程锁定。
- read（读取）：作用于主内存变量，把一个变量值从主内存传输到线程的工作内存中，以便随后的load动作使用
- load（载入）：作用于工作内存的变量，它把read操作从主内存中得到的变量值放入工作内存的变量副本中。
- use（使用）：作用于工作内存的变量，把工作内存中的一个变量值传递给执行引擎，每当虚拟机遇到一个需要使用变量的值的字节码指令时将会执行这个操作。
- assign（赋值）：作用于工作内存的变量，它把一个从执行引擎接收到的值赋值给工作内存的变量，每当虚拟机遇到一个给变量赋值的字节码指令时执行这个操作。
- store（存储）：作用于工作内存的变量，把工作内存中的一个变量的值传送到主内存中，以便随后的write的操作。
- write（写入）：作用于主内存的变量，它把store操作从工作内存中一个变量的值传送到主内存的变量中。

### 对八种操作的规则

- 不允许read和load、store和write操作之一单独出现。即使用了read必须load，使用了store必须write
- 不允许线程丢弃他最近的assign操作，即工作变量的数据改变了之后，必须告知主存
- 不允许一个线程将没有assign的数据从工作内存同步回主内存
- 一个新的变量必须在主内存中诞生，不允许工作内存直接使用一个未被初始化的变量。就是怼变量实施use、store操作之前，必须经过assign和load操作
- 一个变量同一时间只有一个线程能对其进行lock。多次lock后，必须执行相同次数的unlock才能解锁
- 如果对一个变量进行lock操作，会清空所有工作内存中此变量的值，在执行引擎使用这个变量前，必须重新load或assign操作初始化变量的值
- 如果一个变量没有被lock，就不能对其进行unlock操作。也不能unlock一个被其他线程锁住的变量
- 对一个变量进行unlock操作之前，必须把此变量同步回主内存

### 可见性、有序性和原子性

> [并发编程三大特性——原子性、可见性、有序性](https://www.cnblogs.com/yeyang/p/13576636.html)

在单线程环境下我们可以认为整个步骤都是原子性操作，但是在多线程环境下则不同，Java只保证了基本数据类型的变量和赋值操作才是原子性的（注：在32位的JDK环境下，对64位数据的读取不是原子性操作，如long、double）。
要想在多线程环境下保证原子性，则可以通过锁、synchronized来确保。volatile是无法保证复合操作的原子性。

#### 原子性

是指CPU在执行操作时，要么执行要么不执行，对于单个的读/写操作，在多线程环境下保证是原子操作，但复合操作比如i++

- a. 基本类型的读取和赋值操作，且赋值必须是数字赋值给变量，变量之间的相互赋值不是原子性操作。
- b.所有引用reference的赋值操作
- c.java.concurrent.Atomic.* 包中所有类的一切操作

#### 可见性

可见性是指当多个线程访问同一个变量时，一个线程修改了这个变量的值，其他线程能够立即看得到修改的值

```java
//线程1执行的代码
int i = 0;
i = 10;

//线程2执行的代码
j = i;

```

#### 有序性

即程序执行的顺序按照代码的先后顺序执行。

## 生命周期

Java类的生命周期或者说jvm生命周期
<!-- TODO: 自定义类加载器 -->

> 1、*类加载：JVM会查找并加载所有程序所需要的类，并将它们加载到内存中。类加载器按照特定的顺序搜索类，并将它们加载到内存中。  
> 2、*验证：JVM会验证加载的类，以确保它们符合Java语言规范和JVM规范。这个过程包括检查类文件的格式、语法、语义和安全性等方面。  
> 3、*准备：JVM会为所有类分配内存，并设置类变量的默认值。这个过程不包括实例变量。  
> 4、解析：JVM会将所有符号引用解析为直接引用。符号引用是指用名称来引用类、方法、变量等。直接引用是指指向内存中实际对象的指针或偏移量。  
> 5、*初始化：JVM会执行所有类的静态初始化器。这个过程会按照类的依赖关系进行，并且只会执行一次。  
> 6、执行程序：JVM会执行程序的主方法。在执行程序之前，JVM会创建一个主线程，并将主线程和程序的主方法关联起来。  
> 7、*垃圾回收\卸载：JVM会在程序运行过程中进行垃圾回收，以释放不再使用的内存。垃圾回收是自动进行的，程序员不需要手动管理内存。  

并不是所有时候这七个阶段都是顺序进行的，其中加载、验证、准备、初始化、卸载是固定顺序开始的，解析阶段不一定。解析在某些情况下可以在初始化阶段之后再开始，这也是为了支持**运行时绑定（也成为动态绑定）**

### 动态绑定

Java中的动态绑定是指在运行时确定方法的调用版本，而不是在编译时确定。具体来说，当子类重写父类的方法时，如果父类引用指向子类对象，那么调用该方法时会根据实际对象的类型来确定方法的版本，而不是根据引用的类型来确定

```java
class Animal {
    public void makeSound() {
        System.out.println("Animal makes sound.");
    }
}

class Cat extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Cat makes meow.");
    }
}

class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Dog makes woof.");
    }
}

public class Main {
    public static void main(String[] args) {
        Animal animal1 = new Cat();
        Animal animal2 = new Dog();

        animal1.makeSound(); // 输出：Cat makes meow.
        animal2.makeSound(); // 输出：Dog makes woof.
    }
}

```

多态指的是一个对象可以表现出多种形态，即同一个方法调用可以在不同的对象上产生不同的行为。而动态绑定则是实现多态的一种机制，它使得程序可以在运行时动态地确定方法调用的版本，而不是在编译时确定

## 理解按值传递

```java
package demo;

public class Main {
  public static void main(String[] args) {
    int a = 10;
    add(a);
    System.out.println(a); // 10
  }

  static void add(int a) {
    a++;
    System.out.println(a); // 11
  }
}


```

## 协变

Java协变指的是，可以将一个方法的返回类型声明为一个更具体的类型或子类型。[重写](#重写)可以看作是协变。
> 关系可以看作：𝐴≤𝐵时有𝑓(𝐴)≤𝑓(𝐵)成立

### 数组协变

理论上来说，一只猫是一只动物，一只狗也是一只动物

```java
Animal animalOne = new Cat();
Animal animalTwo = new Dog();
```

一只猫是一只动物，那一群猫是一群动物吗？一群狗是一群动物吗？Java数组认为是的。

```java
Animal[] animals = new Cat[2];
```

但既然都是一群动物了，我往这一群动物中添加一只猫、一只狗，它还是一群动物，在编译器看来也是合理合法的，所以也就让它编译过了

```java
Animal[] animals = new Cat[2];
animals[0] = new Cat();
// 下面这行代码会抛运行时异常
animals[1] = new Dog();
```

## 逆变

## 运行期类型检查

在JVM中，运行期类型检查是通过类型检查指令（instanceof）来实现的。

## 类加载器
<!-- TODO: -->

## 实体类
<!-- TODO: -->

## AOP 面向切面编程
<!-- TODO: -->

## 前缀\中缀\后缀表达试

- 前缀
  > 表达式A：*+*8223<br/>+*82*23 <!--TODO: 不知道哪个是对的 -->
  > 表达式B：8*2+(2+1)*3<br/>

前缀表达式的计算机求值：

从右至左扫描表达式，遇到数字时，将数字压入堆栈，遇到运算符时，弹出栈顶的两个数，用运算符对它们做相应的计算（栈顶元素 op 次顶元素），并将结果入栈；重复上述过程直到表达式最左端，最后运算得出的值即为表达式的结果。
例如前缀表达式“- × + 3 4 5 6”：

- 中缀
  > 表达式A：8*2+2*3<br/>
  > 表达式B：8*2+(2+1)*3<br/>
- 后缀
  > 表达式A：8*2+2*3<br/>
  > 表达式B：8*2+(2+1)*3<br/>

## Java 自动装箱和拆箱机制

### 装箱

> Java中的装箱（boxing）指的是将基本数据类型转换为对应的包装类类型，例如将int转换为Integer、将boolean转换为Boolean等。Java的基本数据类型有八种，分别是byte、short、int、long、float、double、char和boolean，而每种基本数据类型都有对应的包装类类型，即Byte、Short、Integer、Long、Float、Double、Character和Boolean。  
> 装箱操作通常比直接使用基本数据类型更加耗费内存和时间，因为每个包装类对象都有自己的对象头和状态信息。因此，在性能敏感的应用中，应该尽量避免频繁的装箱和拆箱操作，并使用基本数据类型来代替包装类类型。  

```java
// 自动装箱
int i = 10;
Integer j = i; 
// 手动装箱
int i = 10;
Integer j = new Integer(i); // 使用构造函数进行装箱
Integer k = Integer.valueOf(i); // 使用静态工厂方法进行装箱

```

### 拆箱

> Java中的拆箱（unboxing）指的是将包装类类型转换为对应的基本数据类型。  
> 拆箱的主要作用是使包装类对象能够像基本数据类型一样被操作，例如从集合类中获取int类型的值、进行数值计算等。
> 把一个包装类转换成其对应的基本数据类型，包装类在堆中，基本数据类型在栈中，由于拆箱后返回的值为基本数据类型，存在栈中，性能损耗不大

```java
// 自动拆箱
Integer i = 10;
int j = i; 
// 手动拆箱
Integer j = new Integer(10);
int i = j.intValue(); // 使用intValue()方法进行拆箱

```

## 注解
<!-- 
TODO: 可以自定义注解，怎么自定义呢
 -->

## java 垃圾回收机制、弱\强引用

### @NonNull

### 案例

#### Bean的校验框架的注解

- @Null 被注释的元素必须为null
- @NotNull 被注释的元素不能为null，可以为空字符串
- @AssertTrue 被注释的元素必须为true
- @AssertFalse 被注释的元素必须为false
- @Min(value) 被注释的元素必须是一个数字，其值必须大于等于指定的最小值
- @Max(value) 被注释的元素必须是一个数字，其值必须小于等于指定的最大值
- @DecimalMin(value) 被注释的元素必须是一个数字，其值必须大于等于指定的最小值
- @DecimalMax(value) 被注释的元素必须是一个数字，其值必须小于等于指定的最大值
- @Size(max,min) 被注释的元素的大小必须在指定的范围内。
- @Digits(integer,fraction) 被注释的元素必须是一个数字，其值必须在可接受的范围内
- @Past 被注释的元素必须是一个过去的日期
- @Future 被注释的元素必须是一个将来的日期
- @Pattern(value) 被注释的元素必须符合指定的正则表达式。
- @Email 被注释的元素必须是电子邮件地址
- @Length 被注释的字符串的大小必须在指定的范围内
- @Range 被注释的元素必须在合适的范围内
- @NotEmpty：用在集合类上，不能为null，并且长度必须大于0
- @NotBlank：只能作用在String上，不能为null，而且调用trim()后，长度必须大于0
