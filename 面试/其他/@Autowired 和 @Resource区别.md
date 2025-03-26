# @Autowired 和 @Resource区别

### **1. 来源不同**

- **`@Autowired`**
  属于 **Spring 框架**的注解（`org.springframework.beans.factory.annotation`），是 Spring 生态的专有实现。
- **`@Resource`**
  属于 **Java 标准注解**（`javax.annotation`），遵循 JSR-250 规范，是 Java EE 的一部分（但也可用于 Spring）。

------

### **2. 注入方式的默认行为**

- **`@Autowired`**
  默认按 **类型（ByType）** 注入依赖。

  - 如果存在多个相同类型的 Bean，需要结合 `@Qualifier` 指定具体 Bean 的名称。

  - 示例：

    java

    复制

    ```
    @Autowired
    @Qualifier("myServiceA") // 指定 Bean 名称
    private MyService myService;
    ```

- **`@Resource`**
  默认按 **名称（ByName）** 注入依赖（即 `name` 属性）。

  - 如果未指定 `name`，则退化为按类型（ByType）注入。

  - 示例：

    java

    复制

    ```
    @Resource(name = "myServiceA") // 显式指定名称
    private MyService myService;
    ```

------

### **3. 依赖的框架**

- **`@Autowired`**
  必须依赖 **Spring 容器**（如 Spring Framework、Spring Boot）。
- **`@Resource`**
  不依赖 Spring，但需要 Java EE 环境或额外的依赖（如 `javax.annotation-api`）。

------

### **4. 参数支持**

- **`@Autowired`**
  支持 `required` 属性，用于标记依赖是否必须存在：

  java

  复制

  ```
  @Autowired(required = false) // 允许注入失败（默认为 true）
  private MyService myService;
  ```

- **`@Resource`**
  支持 `name` 和 `type` 属性，用于精确指定 Bean 的名称或类型：

  java

  复制

  ```
  @Resource(name = "myServiceA", type = MyService.class)
  private MyService myService;
  ```

------

### **5. 适用场景**

- **使用 `@Autowired` 的场景**
  - 项目完全基于 Spring 生态。
  - 需要按类型注入，或需要与 `@Qualifier` 结合使用。
  - 需要控制依赖的必需性（`required=false`）。
- **使用 `@Resource` 的场景**
  - 希望代码与 Spring 解耦（兼容 Java EE 或其他框架）。
  - 需要按名称注入，且名称与 Bean 的 `id` 或 `name` 一致。
  - 在非 Spring 项目中（如 Jakarta EE）。

------

### **6. 示例对比**

假设有以下两个 Bean：

java

复制

```
@Component("serviceA")
public class ServiceA implements MyService { ... }

@Component("serviceB")
public class ServiceB implements MyService { ... }
```

- 使用 `@Autowired` 注入：

  java

  复制

  ```
  @Autowired
  @Qualifier("serviceA") // 必须指定名称
  private MyService myService;
  ```

- 使用 `@Resource` 注入：

  java

  复制

  ```
  @Resource(name = "serviceA") // 直接指定名称
  private MyService myService;
  ```

------

### **总结**

| 特性             | `@Autowired`        | `@Resource`                |
| :--------------- | :------------------ | :------------------------- |
| **来源**         | Spring 专属         | Java 标准                  |
| **默认注入方式** | 按类型（ByType）    | 按名称（ByName）           |
| **依赖框架**     | Spring 容器         | Java EE / Jakarta EE       |
| **灵活性**       | 需配合 `@Qualifier` | 支持 `name` 和 `type` 属性 |
| **适用场景**     | Spring 项目         | 多框架兼容或解耦需求       |

根据项目需求选择：

- **优先用 `@Autowired`**：与 Spring 强绑定，需要类型安全。
- **优先用 `@Resource`**：需要代码通用性，或按名称注s入更直观