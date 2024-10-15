# mybatis传值方式

MyBatis 是一个优秀的持久层框架，支持多种传递参数的方式来进行 SQL 语句的动态绑定。以下是 MyBatis 常见的几种传值方式及其适用场景和示例。

### 1. **单个参数传递**

#### 场景：  

适用于传递单个简单类型参数（如 `int`、`String` 等）的情况，通常是用于单一查询条件的场景。

#### 说明：

MyBatis 会自动将单个参数传递给 SQL 语句，并且在 `mapper.xml` 中可以直接使用 `#{}` 引用该参数。

#### 示例：  

```java
public interface UserMapper {
    User selectUserById(int id);
}
xml<select id="selectUserById" resultType="User">
    SELECT * FROM user WHERE id = #{id}
</select>
```

在上面的例子中，传递的参数是一个 `int` 类型的 `id`，可以通过 `#{id}` 来引用。

### 2. **多个参数传递**

#### 场景：

当需要传递多个简单参数（如多个 `int`、`String` 等）时，适用于多个查询条件的场景。

#### 说明：

MyBatis 会自动将多个参数封装到一个 `Map` 中，参数名会以 `param1`, `param2`, ... 的形式存在，或者可以手动为每个参数命名。

#### 示例：

```java
public interface UserMapper {
    User selectUserByNameAndAge(String name, int age);
}
xml<select id="selectUserByNameAndAge" resultType="User">
    SELECT * FROM user WHERE name = #{name} AND age = #{age}
</select>
```

在这个例子中，MyBatis 自动将 `name` 和 `age` 参数传递给 SQL 语句。

如果想为参数命名，也可以使用 `@Param` 注解：

```
public interface UserMapper {
    User selectUserByNameAndAge(@Param("name") String name, @Param("age") int age);
}
```

此时 XML 中的 SQL 可以这样写：

```xml
xml<select id="selectUserByNameAndAge" resultType="User">
    SELECT * FROM user WHERE name = #{name} AND age = #{age}
</select>
```

### 3. **POJO 传参**

#### 场景：

当参数较多或涉及复杂结构时，适合将参数封装成一个对象来传递。常用于插入、更新等操作。

#### 说明：

MyBatis 可以直接接受  Bean（POJO）对象作为参数，并且可以在 SQL 中通过对象的属性进行引用。

#### 示例：

```java
public class User {
    private int id;
    private String name;
    private int age;
    // getter & setter
}
public interface UserMapper {
    User selectUser(User user);
}
xml<select id="selectUser" resultType="User">
    SELECT * FROM user WHERE id = #{id} AND name = #{name} AND age = #{age}
</select>
```

在这个例子中，传递的参数是一个 `User` 对象，SQL 语句通过 `#{}` 来引用对象的属性。

### 4. **`Map` 传参**

#### 场景：

适用于需要传递不固定数量的参数或者动态传递键值对的场景。一般用于复杂的查询条件。

#### 说明：

MyBatis 支持使用 `Map` 作为参数传递方式，SQL 中可以通过 `#{}` 引用 `Map` 的键来获取对应的值。

#### 示例：

```java
public interface UserMapper {
    User selectUserByMap(Map<String, Object> params);
}
xml<select id="selectUserByMap" resultType="User">
    SELECT * FROM user WHERE name = #{name} AND age = #{age}
</select>
```

在这个例子中，`params` 是一个 `Map`，包含 `name` 和 `age`，SQL 中通过 `#{name}` 和 `#{age}` 来获取值。

### 5. **集合传参（List/Array）**

#### 场景：

当需要批量传递多个相同类型的参数时，如批量查询、批量删除等操作场景。

#### 说明：

MyBatis 支持传递集合类型（如 `List`、`Set`、数组等）。在 SQL 中可以使用 `<foreach>` 标签来遍历集合。

#### 示例：

```java
public interface UserMapper {
    List<User> selectUsersByIds(List<Integer> ids);
}
xml<select id="selectUsersByIds" resultType="User">
    SELECT * FROM user WHERE id IN
    <foreach item="id" index="index" collection="ids" open="(" separator="," close=")">
        #{id}
    </foreach>
</select>
```

在这个例子中，传递的是 `List<Integer>` 类型的 `ids` 集合，SQL 使用 `<foreach>` 标签来遍历集合。

### 6. **注解传参（`@Param`）**

#### 场景：

适用于希望显式为方法中的多个参数命名时，通常用于简化参数传递并提高代码的可读性。

#### 说明：

通过 `@Param` 注解可以为每个参数指定一个名称，在 SQL 中使用时可以通过 `#{}` 引用这个名称。

#### 示例：

```java
public interface UserMapper {
    User selectUserByNameAndAge(@Param("name") String name, @Param("age") int age);
}
xml<select id="selectUserByNameAndAge" resultType="User">
    SELECT * FROM user WHERE name = #{name} AND age = #{age}
</select>
```

这种方式可以清晰地标识参数，避免多个参数时使用 `param1`、`param2` 等不便于阅读的命名方式。

### 总结

- **单个参数传递**：适合简单的单一条件查询场景。
- **多个参数传递**：适合多个简单条件查询，可以通过 `@Param` 明确指定参数名。
- **POJO 传参**：适合较为复杂的对象结构，可以直接传递  Bean。
- **`Map` 传参**：适合动态、灵活的键值对传递场景。
- **集合传参**：适合批量操作，例如批量查询、批量插入、批量删除。
- **注解传参**：用于更清晰的参数命名和管理。

每种传参方式都根据实际需求进行选择，MyBatis 提供的灵活性使得在不同场景下都能快速实现高效的数据操作。