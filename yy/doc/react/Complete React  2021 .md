APRIL 9, 2021/[#REACT](https://www.freecodecamp.org/news/tag/react/)

# The Complete React Tutorial for 2021 – Learn Major React Concepts by Building a Project

![Reed Barger](https://www.freecodecamp.org/news/content/images/size/w100/2021/05/reed-barger-gravatar.jpeg)

#### [Reed Barger](https://www.freecodecamp.org/news/author/reed/)

![The Complete React Tutorial for 2021 – Learn Major React Concepts by Building a Project](https://www.freecodecamp.org/news/content/images/size/w2000/2021/04/the-complete-react-tutorial-2021.png)

Welcome to the complete React tutorial for 2021. This guide should help you become effective with React as quickly as possible as you build a complete application along the way.

Compared to many tutorials you might have gone through before, this one is meant to be thoroughly practical from start to finish.

You will learn how to create an entire React application all within around 100 lines of code, which makes use of many of the core concepts of React: hooks, state management, forms, JSX elements, components, props, styling, and conditionals.

And best of all, you will learn all of these concepts while coding yourself, hands-on. Let's get started!

We're going to create our React application by going to the website [react.new](https://react.new/).

What this will do is create a new code sandbox for us. We can use code sandbox to create and develop complete React applications without having to install anything on our computer.

Once you visit react.new, you will see your code editor and, on the right hand side, we see a live version of our application to which we can make changes:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-1.png)

> Quick tip: Make sure to hit command/ctrl S. Doing so will fork our sandbox and create a special URL that we can revisit in the future.

Right now we're looking at our app component, which is the only component that's being displayed in our application. If we look at our file explorer on the left, we'll see app is being imported and rendered here within this index.js file.

```react
// src/index.js
import { StrictMode } from "react";
import ReactDOM from "react-dom";

import App from "./App";

const rootElement = document.getElementById("root");
ReactDOM.render(
  <StrictMode>
    <App />
  </StrictMode>,
  rootElement
);
```

What does all of this code do?

It simply "renders" or displays our app by injecting it into an index.html file, which is what we see on the right hand side of the page.

The code also finds and puts our app in the so-called root element (a div with the id of "root"). If you want see where that element is, you can find it within our public folder, specifically in the index.html file.

## How to Use JSX

Now that we have a working React app, let's start building it and changing what we see.

Let's begin within our div by removing this h2 element, and within our h1, just calling our app "Todo List":

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-2.png)

What we are working with here is called **JSX**. It looks very similar to HTML, but is in fact JavaScript. We use it to build the structure of our application, just as we would use HTML.

> We can use any standard HTML elements within JSX: divs, any heading element, paragraph, spans, buttons, and so on.

It's important to note that there are some minor differences between JSX and HTML.

The attributes that we use on JSX are slightly different than in normal HTML elements. They are written in the camelcase style, which is a standard way of writing variables or properties in JavaScript.

For example, to apply a class on a JSX element, we use an attribute called `className`. For normal HTML, that would just be called `class`.

```react
// src/App.js
import "./styles.css";

export default function App() {
  return (
    <div className="App">
      <h1>Todo List</h1>
    </div>
  );
}
```

If we use `class` instead of `className` for JSX, we're going to get a warning saying class is an invalid DOM property:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-3.png)

## How to Create a List of Todo Elements

Since we're making a todo application, let's create our todo list underneath our h1 header.

We could begin by making an unordered list with some list items as children elements. Each todo would be listed within an `li` element:

```react
// src/App.js
import "./styles.css";

export default function App() {
  return (
    <div className="App">
      <h1>Todo List</h1>
      
      <ul>
      	<li>Todo Item</li>
      </ul>
    </div>
  );
}
```

We can do something better as React developers, however. Instead, let's make a dedicated component that is responsible for displaying our todos.

## How to Create New React Components

**Components** are the backbone of any React application.

We use components to separate different parts of our user interface. This makes them reusable wherever we need them across our app, it better organizes our code, and it makes it easier to understand our projects.

> Components fulfill an important concept in programming which is called "separation of concerns." This means it is preferable for each part of our component to have its own clearly defined role and responsibilities, separate from any other component.

Just as we have an App component, we can create a component to be displayed within App. Since it is a list of todos, let's call it "TodoList":

```react
// src/App.js
import "./styles.css";

export default function App() {
  return (
    <div className="App">
      <h1>Todo List</h1>
      
      <TodoList /> {/* component with single tag */}
    </div>
  );
}
```

## React Component rules

Every component must begin with a capital letter. And once a component is declared, it can be written and used very similarly to an HTML element.

A component can consist of just one tag or two tags. If it doesn't have anything between the two tags, which are called **children**, it should only have as one tag as the code above displays: `<TodoList />`.

Additionally, if a component or element consists of just one tag, it must be self-closing. Meaning, it must end in a forward slash (like `<TodoList />` and not `<TodoList>`).

We are attempting to display our TodoList component, but we haven't created it yet. To do that, we can create another function component like App, with the name TodoList.

At this point, we're going to get this error saying nothing was returned from render:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-4.png)

We need to return something, specifically some JSX. Every component we make must return JSX elements and components (which must also, ultimately, be composed of JSX).

In our case, we want to return our list of todos. Let's take our unordered list with all of our list items that we want to show. We don't really have any data just yet, so let's create some.

In particular, let's create a set of todo data, which we can include in an array. Let's add this to the App component:

```react
// src/App.js
import "./styles.css";

export default function App() {
  const todos = [
    { id: 1, text: "Wash dishes", done: false },
    { id: 2, text: "Do laundry", done: false },
    { id: 3, text: "Take shower", done: false }
  ];

  return (
    <div>
      <h1>Todo List</h1>
      <TodoList />
    </div>
  );
}

function TodoList() {}
```

## How to Pass Data to Components with Props

Now the question is – how do we pass all this data to and display it within our todo list?

With React components, we can do that with special properties that we add to the component called props.

**Props** are custom attributes we can add to React components to pass data to our components. They are the React equivalent of arguments in JavaScript.

Since our data is called todos, let's name our prop the same: "todos". We use the equals operator to set a prop's value as well as a set of curly braces. This is because our todos array is a variable (a dynamic value):

```react
// src/App.js
import "./styles.css";

export default function App() {
  const todos = [
    { id: 1, text: "Wash dishes", done: false },
    { id: 2, text: "Do laundry", done: false },
    { id: 3, text: "Take shower", done: false }
  ];

  return (
    <div>
      <h1>Todo List</h1>
      <TodoList todos={todos} />
    </div>
  );
}

function TodoList() {}
```

> If we wanted to make it a string, for example, we would wrap it in a set of quotes. But since this is a dynamic value that can change, we want to always include it within curly braces.

Within the TodoList component, where are our props going to be received to ultimately display our todos data? They're going to be received exactly where any function would receive their arguments.

We receive our prop data on an object which we usually call "props", but we can give it whatever name we like.

We can see that we're passing this data down by using `console.log(props)`. If we look at our console tab, we have this property on our props object called "todos".

It has an array of three items just like we would expect:

```react
// src/App.js
import "./styles.css";

export default function App() {
  const todos = [
    { id: 1, text: "Wash dishes", done: false },
    { id: 2, text: "Do laundry", done: false },
    { id: 3, text: "Take shower", done: false }
  ];

  return (
    <div>
      <h1>Todo List</h1>
      <TodoList todos={todos} />
    </div>
  );
}

function TodoList(props) {
  console.log(props) // {todos: Array(3)}
}
```

## How to Map Over Array Items with the Map Function

In order to display each of these list items, we can take the array that is on `props.todos`.

In particular, we can use a special function that React gives us on the todos array called **map**.

Since we want to display this within TodoList, we once again need to use a set of curly braces to display it within our JSX. Using `props.todo.map`, we will map over this array just like we would a normal JavaScript array.

> The React map function is slightly different than the normal JavaScript map function because it is made to return and render JSX elements.

`.map()` accepts an inner function and in that function, we can get access to each todo. Using an arrow function, we can return each todo within its own JSX.

Finally, we can immediately return that JSX by wrapping it in a set of parentheses:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-5.gif)

Within our inner function, we get access to each todo's data. To display that data, we can take each todo which we know is an object. We can use a set of curly braces to output the dynamic value of whatever is on `todo.text`.

When we do that, we can see our three todos:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-6.png)

## What are React Keys (and Why They Matter)?

If we look at the console tab at the bottom we will see a warning, saying each child in the list should have a "unique key prop."

The reason for this is that React needs to keep track of the order of each of the items in our list. It does so with the help of a special React prop called a **key**.

> For a key, you generally want to use a unique identifier, a unique value that is only associated with one piece of data. In our case, to identify each todo's data we will use the unique number provided on `todo.id`.

So why are keys important? It is important for React to figure out how it should appropriately update our user interface. If we were to update a todo's text or done value, the key is what tells React which todo item needs to be updated.

Once we add the key prop to the element or component that we're looping over, we no longer get that warning:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-7.png)

## How to Get Individual Props with Destructuring

Note that one additional shorthand is that instead of referencing the entire object within the TodoList, we can reference the individual properties on that object to make our code a little bit shorter by using object destructuring.

> Object destructuring is not a React concept, but a standard JavaScript feature that makes accessing object properties easier by immediately declaring them as individual variables.

As of right now, we only have one prop being passed down to TodoList, so let's destructure that one prop, `todos`, individually.

To do so, we add a set of curly braces within our functions parameters, and just grab the property that we need from the props object. This means that we can change `props.todos` to just `todos`:

```react
// src/App.js
import "./styles.css";

export default function App() {
  const todos = [
    { id: 1, text: "Wash dishes", done: false },
    { id: 2, text: "Do laundry", done: false },
    { id: 3, text: "Take shower", done: false }
  ];

  return (
    <div>
      <h1>Todo List</h1>
      <TodoList todos={todos} />
    </div>
  );
}

// using object destructuring on the props object
function TodoList({ todos }) {
  return (
    <ul>
      {todos.map((todo) => (
        <li key={todo.id}>{todo.text}</li>
      ))}
    </ul>
  );
}
```

## How to Add New Todo List Items

Now what about adding some new todos to our list?

Underneath our TodoList component, let's add a new component that's responsible for adding new todos. A logical name for this would be "AddTodo".

We can create this underneath our to do list component. Let's have AddTodo return a form element that contains a basic text input and a submit button.

```react
// src/App.js
import "./styles.css";

export default function App() {
  const todos = [
    { id: 1, text: "Wash dishes", done: false },
    { id: 2, text: "Do laundry", done: false },
    { id: 3, text: "Take shower", done: false }
  ];

  return (
    <div>
      <h1>Todo List</h1>
      <TodoList todos={todos} />
      <AddTodo />
    </div>
  );
}

function TodoList({ todos }) {
  return (
    <ul>
      {todos.map((todo) => (
        <li key={todo.id}>{todo.text}</li>
      ))}
    </ul>
  );
}

function AddTodo() {
  return (
    <form>
      <input placeholder="Add todo" />
      <button type="submit">Submit</button>
    </form>
  );
}
```

> Note that any JSX element that consists of just one tag (such as our input) must end in a forward slash. If we do not include it, we're going to get a compiler error saying "unterminated JSX contents."

Now the question is: how do we type into our input, submit our form, and have a new todo added to our todos array?

## How to Handle Form Submissions in React

To take care of submitting our form, we need to start working with events in React.

In our case, we want to use the "submit" event when our form is submitted by our user and for React to handle that form submission by adding a new todo.

React adds a special prop to the form element called `onSubmit`. onSubmit accepts a function within a set of curly braces. Let's create a new function, which we will call `handleAddTodo`.

> Note that most functions that handle events in React are prefixed with the word "handle". It's ultimately up to you how you want to name your functions, but this is a helpful convention.

It's important to note that this function should be created within the component itself (AddTodo), not outside of it. When `handleAddTodo` is passed to the `onSubmit` prop, it will be called when our form is submitted:

```react
// src/App.js
import "./styles.css";

// ...

function AddTodo() {
  function handleAddTodo() {}

  return (
    <form onSubmit={handleAddTodo}>
      <input placeholder="Add todo" />
      <button type="submit">Submit</button>
    </form>
  );
}
```

## How to Prevent Default Form Behavior

When we click the submit button or hit the return key, data from the submit event is passed automatically to our function that's connected to onSubmit. We receive that event data in the parameters of `handleAddTodo`.

The first thing that we want to do with this event is call a method on it called `.preventDefault()`. This method prevents the default action whenever we submit a form:

```react
// src/App.js
import "./styles.css";

// ...

function AddTodo() {
  function handleAddTodo(event) {
    event.preventDefault();
  }

  return (
    <form onSubmit={handleAddTodo}>
      <input placeholder="Add todo" />
      <button type="submit">Submit</button>
    </form>
  );
}
```

Whenever we submit a form, by default, the page is refreshed. We don't want that behavior with React – we want JavaScript to control whatever happens next.

After preventing a refresh, we want to get access to what was typed into the input to create a new todo with it. How do we do that?

## How to Access Form Data on Submit

The way that we get access to all of the elements within our form is with the help of the property `event.target.elements`.

First of all, this will give us the event target, which is the form itself. `elements` is a property that will give us all of the elements within that form, including our input and our submit button.

If we were to console.log `event.target.elements` right now, submit our form, and look at our console, we see just an object with a couple of properties, one called "0", and one called "1".

This isn't very helpful to us, although we do see that it is our input and our button:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-8.png)

Instead, we want to get what was typed into our input.

To do so, we can add either an "id" or a "name" attribute to our input. Let's add the name attribute with a value of "addTodo". When we hit submit again, this will give us a new property on the elements object also called `addTodo`. From that reference, we can very easily get what was typed into it.

This allows us to use `event.target.elements.addTodo.value` to get what was typed in whatever text was typed in. When we do so, when we type text into our input, and hit submit, we see it logged to the console:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-9.gif)

Now that we have our text, we'll put it in a variable called "text". Using this, we want to create a new todo.

We know that each todo is an object and it has to consist of the properties id, text, and done. Let's create a variable `todo` and that will be equal to a new object where the id will be 4, the text will be equal to the text that we're getting from the elements object, and we can set done to false.

By default, new todos that are added are not going to be done:

```react
// src/App.js
import "./styles.css";

//...

function AddTodo() {
  function handleAddTodo(event) {
    event.preventDefault();
    const text = event.target.elements.addTodo.value;
    const todo = {
      id: 4,
      text,
      done: false
    };
  }

  return (
    <form onSubmit={handleAddTodo}>
      <input name="addTodo" placeholder="Add todo" />
      <button type="submit">Submit</button>
    </form>
  );
}
```

And finally, the big question is, how do we add this todo to our array, `todos`?

## Introduction to State in React

This is where the concept of state comes in.

Right now we're dealing with static data – there is no real way to update this todos array. To be clear, there *is* a way to do it using JavaScript, but what we are not currently able to do is tell React, even if we were to update it, that it needs to **re-render** this list.

In other words, to perform an update to our data and then show us the updated data in our view. So while we could update the data, we also need React to show our users the updated data.

**State** is required to fix our problem.

> State is a means of managing our application data and also allows React to update our UI (user interface) in response to data changes.

## How to Manage State in React with the useState Hook

We can manage state in React using the `useState` hook. To use the useState hook, the first thing that we need to do is import React up at the top, because useState comes from the core React library.

After that, we can simply call the useState hook up at the top of our app component. Once we call useState just like a normal function, we will pass in our entire array of todos as our initial data. Our application will break for a moment since we're no we're no longer showing our todos just yet.

useState returns an array with two elements:

1. The initial value we called useState with (our array of todos) and this becomes our state variable
2. A special function that allows us to update what is stored in the state variable

We can destructure the values that are returned from useState by adding a set of array brackets to immediately get the values that are returned from it. First the state and second, the function to update the state:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-10.gif)

We'll call our state variable `todos` and the setter to manage our state `setTodos`.

All we have to do to update our state is to pass it, whatever we want the new state to be. This `setTodos` function is going to be passed down to our AddTodo component, so let's add that as a prop of the same name. We'll also destructure `setTodos` from our props object within AddTodo.

And finally, we can call `setTodos` at the bottom of `handleAddTodo`. What's great about this function is instead of having to pass down the todos array as well, this function can give us the previous state with the help of a function that we can receive inside of it:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-11.gif)

This may seem strange at first, but within `setTodos` we get access to the previous todo data. If we write an arrow function or any function for that matter, we can simply provide what we want the new state to be.

> The benefit of being able to access the previous state variable's value directly within the setter function is that it prevents us from having to pass down the entire todos state variable as an additional prop to every component in which we want to update its value.

If we wanted to empty our todos state, we could just return an empty array right here. If we were to submit our form, we would see that all of our todos were removed.

Once we submit our form, state is updated, and our app is re-rendered as a result.

## Re-renders in React

Note that any re-render within a parent component will cause any child components to re-render. That means whenever our todo data is updated, the TodoList component (a child of the App component) is updated with that new data.

If we go back to `handleAddTodo`, we can take our previous todos and use the `.concat()` method to add this new todo to our array in state. All we have to do is return this expression.

Let's add a new todo, such as "Balance Checkbook." Once we hit submit, we see that immediately added to our list:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-12.gif)

Now there's one problem here: we aren't clearing out our input after our form is submitted.

This means if we wanted to add another todo we would have to manually clear it out. How do we take this input's value and clear it out?

## React refs and useRef

To perform common actions such as clearing out an input's value or focusing our input we can use what's called a **ref**.

> A ref is a feature that React provides to reference to a given DOM element.

In this case, we want a reference to this input element with the name of "addTodo."

Just like our state, we can work with refs by calling the appropriate React hook. To create a ref, we just need to call `React.useRef()` at the top of AddTodo. We don't have to pass it an initial value, but we can give it a default value if we needed to.

We will call this created ref `inputRef`. Using inputRef, we can create a reference to our input element which we can access wherever we like by using the built-in ref prop by setting `ref={inputRef}`:

```react
// src/App.js
import React from "react";
import "./styles.css";

//...

function AddTodo({ setTodos }) {
  const inputRef = React.useRef();

  function handleAddTodo(event) {
    event.preventDefault();
    const text = event.target.elements.addTodo.value;
    const todo = {
      id: 4,
      text,
      done: false
    };
    setTodos((prevTodos) => {
      return prevTodos.concat(todo);
    });
  }

  return (
    <form onSubmit={handleAddTodo}>
      <input name="addTodo" placeholder="Add todo" ref={inputRef} />
      <button type="submit">Submit</button>
    </form>
  );
}
```

What does this do? It allows us within `handleAddTodo` to use the property `inputRef.current`, which contains the input element itself. If we were to log `input.ref.current`, we would see our input element.

We have a direct reference to our input, which means we access any property that we like off of it. In our case, we want to take the value of the input on the value property. To clear the value from our input, we can just mutate inputRef directly by setting value to an empty string:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-13.gif)

Whenever we hit submit, our input is cleared out without having to clear it out ourselves manually.

## Essential Rules of React Hooks

Since useRef is another React hook, we're starting to see some common features among React hooks. They are often prefixed with the word "use". In fact, most all React hooks have this prefix to denote that they are hooks and should be used as such.

Additionally, React hooks are called up at the very top of function components. Hooks cannot be used within class components. And finally, hooks cannot be conditional (that is, used within an if statement).

But as you can see, there's nothing too special about React hooks. They operate very much like regular JavaScript functions.

## How to Mark Todos as Done with onClick

After creating todos, we want to toggle them done – to strike through them if we've finished a given todo. How do we add this feature?

If we go back to our list item, within TodoList, we can see what that will look like by applying some inline styles. We saw how to add styles through classes. For styles that we want to apply inline to any given element, we cannot use the same syntax as we would with normal HTML.

If we tried to using the HTML syntax, we're going to get an error telling us "the style prop expects style properties within an object, not within a string":

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-14.png)

To fix this, we will provide an object. We need to provide this object within another set of curly braces. Then, we will provide any property like we would in a normal JavaScript object to apply this strike through style.

For each of our list items, we can set the property `textDecoration` to "line-through":

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-15.png)

We do not want every item to be struck through, we only want this to be applied if a given todo is done. How do we do that?

We can use a normal JavaScript conditional, in particular a ternary, to say that if a given todo's property done is true, then we want to apply the strike through value for text decoration, otherwise not.

If we change one of our todos array to have a done value of `true`, we see that that style rule is applied:

```react
// src/App.js

//...

function TodoList({ todos }) {
  return (
    <ul>
      {todos.map((todo) => (
        <li
          style={{
            textDecoration: todo.done ? "line-through" : ""
          }}
          key={todo.id}
        >
          {todo.text}
        </li>
      ))}
    </ul>
  );
}

//...
```

How do we actually toggle that todo?

We might want our user to click or double click on our todo in order to strike through it. That means we want to see how to register and handle a new type of event – a click event.

To handle a click event with React we provide the `onClick` prop to a given element for which we want to register that event. In this case, it's the `li` element.

Once again, we need to connect it to a function to handle our click event. We're going to call this `handleToggleTodo` and create it within our TodoList component. In this case, our function that we use to handle the event doesn't have to receive any event data. This function will handle updating our todo's state.

We want `handleToggleTodo` to go through the `todos` array and see if the one that the user has clicked on exists in our array. If so, its done value can be toggled to the opposite boolean value.

To receive the appropriate todo data for the appropriate list item that is clicked on, we can call `handleToggleTodo` as an inline arrow function and pass the todo data as an argument:

```react
// src/App.js

//...

function TodoList({ todos }) {
  function handleToggleTodo(todo) {}
    
  return (
    <ul>
      {todos.map((todo) => (
        <li
          onClick={() => handleToggleTodo(todo)}
          style={{
            textDecoration: todo.done ? "line-through" : ""
          }}
          key={todo.id}
        >
          {todo.text}
        </li>
      ))}
    </ul>
  );
}

//...
```

To update our todos state, we'll pass down `setTodos` to our TodoList component. We'll pass down `setTodos` as a prop to TodoList, and destructure it from the props object.

Once again, we can call `setTodos` and get access to the previous todos by including an inner function. First, what we can do is take our entire todos array and map over it with the `.map()` array function.

In the inner function passed to map, we will check that the todos id we're mapping over is equal to the todo that we've clicked on. If so, we return a new object with all of the previous todo's properties, but with `done` toggled to its opposite boolean value:

```react
// src/App.js

//...

function TodoList({ todos, setTodos }) {
  function handleToggleTodo(todo) {
    // confused by this code? Here's what it says:
      
    // if a todo's id is equal to the one we clicked on,
    // just update that todo's done value to its opposite,
    // otherwise, do nothing (return it)
      
    const updatedTodos = todos.map((t) =>
      t.id === todo.id
        ? {
            ...t,
            done: !t.done
          }
        : t
    );
  }

  return (
    <ul>
      {todos.map((todo) => (
        <li
          onDoubleClick={() => handleToggleTodo(todo)}
          style={{
            textDecoration: todo.done ? "line-through" : ""
          }}
          key={todo.id}
        >
          {todo.text}
          <DeleteTodo todo={todo} setTodos={setTodos} />
        </li>
      ))}
    </ul>
  );
}

//...
```

Otherwise, if that todo that we're iterating over is not the one that we clicked on, we just want to return it (without changing it). This updated array is what we'll pass to `setTodos` to update our state.

If we click on a todo, we toggle it done. If we click on it again, it's toggled back to undone:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-16.gif)

For this to work appropriately, to see that a past todo's id is equal to the todo that we're clicking on, we need to make sure that each todo's id is unique.

Instead of setting each new todo to have an id of 4, we can just use `Math.random()` to make a semi-random value and ensure there are no list items with the same id.

Finally, as an alternative to `onClick`, we can use another event prop, `onDoubleClick`,  in the event that users accidentally click a given todo. Now if a user double clicks a list item, only then do we toggle it done.

## How to Handle Deleting Todos

The final bit of functionality that we're looking for is to be able to delete a given todo.

We can add that functionality within TodoList by adding another nested component. Underneath our todo text, we'll add a new component: DeleteTodo. Let's declare this new component above where we declared AddTodo.

What will this component consist of? In it, we will return a span, which will function like a button for us. A user can click on this and delete a given todo.

> If you want a non-button element to operate like a button, we need to make its "role" property set to "button".

To our span, let's add some style rules – we can give it a color of red, make it bold, and separate it from the todo text by setting `marginLeft: 10`. What's neat about the style object is that we don't have to say 10 pixels as a string – we can use the value 10 or include any integer that we like.

Here is the code for our DeleteTodo component so far:

![img](https://www.freecodecamp.org/news/content/images/2021/04/tutorial-17.png)

To delete a todo, we want to be able to click on it and show a confirmation dialog. If the user confirms they want to delete it, only then is the todo removed.

Since we're mapping over each todo item, including DeleteTodo, we can pass down a prop called just `todo` with each todo's data on it.

In DeleteTodo, on our span element, we want to add an `onClick` to handle deleting our todo. To handle this, we will call a new function: `handleDeleteTodo`.

Using this function, we first want to show a confirmation dialog. We can do so by saying `window.confirm()` with the message, "Do you want to delete this"? `window.confirm` is going to return a value of true or false based on whether the user has confirmed the dialog or not. We'll put the result of this action in a variable called `confirmed`:

```react
// src/App.js
// ...

function TodoList({ todos, setTodos }) {
  // ...

  return (
    <ul>
      {todos.map((todo) => (
        <li
          onDoubleClick={() => handleToggleTodo(todo)}
          style={{
            textDecoration: todo.done ? "line-through" : ""
          }}
          key={todo.id}
        >
          {todo.text}
          {/* pass todo data down as a prop to DeleteTodo */}
          <DeleteTodo todo={todo} />
        </li>
      ))}
    </ul>
  );
}

function DeleteTodo({ todo, setTodos }) {
  function handleDeleteTodo() {
    const confirmed = window.confirm("Do you want to delete this?");
    if (confirmed) {
      // take care of deleting the todo
    }
  }

  return (
    <span
      onClick={handleDeleteTodo}
      role="button"
      style={{
        color: "red",
        fontWeight: "bold",
        marginLeft: 10,
        cursor: "pointer"
      }}
    >
      x
    </span>
  );
}

//...
```

If `confirmed` is true, only then do we want to delete the todo.

To do that, we need to use `setTodos` once again. We'll pass it down one more level from TodoList to the DeleteTodo component and destructure it from the props object.

Then, within `handleDeleteTodo`, we can call it and use the inner function to get the previous todos. To remove the todo that a user has clicked on, we can filter through this array to make sure that we are removing the one that the user selected.

To do so, we make sure all the todos in our array do not have an id equal to the one we are attempting to delete:

```react
// src/App.js

// ...

function DeleteTodo({ todo, setTodos }) {
  function handleDeleteTodo() {
    const confirmed = window.confirm("Do you want to delete this?");
    if (confirmed) {
      setTodos((prevTodos) => {
        return prevTodos.filter((t) => t.id !== todo.id);
      });
    }
  }

  return (
    <span
      onClick={handleDeleteTodo}
      role="button"
      style={{
        color: "red",
        fontWeight: "bold",
        marginLeft: 10,
        cursor: "pointer"
      }}
    >
      x
    </span>
  );
}

// ...
```

Now if we attempt to delete one of our todos, we see our confirmation dialog, we hit "ok", and immediately it's removed from our list.

If we delete all of our todos, we no longer see anything. If we want to tell our user there are no todos in the list when the array is empty, let's head up to our TodoList component.

If we have an empty todos array, we can add a conditional above our return and check if our array's length is equal to 0. If so, we will display a paragraph element with the text "No todos left":

```react
// ...

function TodoList({ todos, setTodos }) {
  function handleToggleTodo(todo) {
    const updatedTodos = todos.map((t) =>
      t.id === todo.id
        ? {
            ...t,
            done: !t.done
          }
        : t
    );
    setTodos(updatedTodos);
  }

  if (!todos.length) {
    return <p>No todos left!</p>;
  }

  return (
    <ul>
      {todos.map((todo) => (
        <li
          onDoubleClick={() => handleToggleTodo(todo)}
          style={{
            textDecoration: todo.done ? "line-through" : ""
          }}
          key={todo.id}
        >
          {todo.text}
          <DeleteTodo todo={todo} setTodos={setTodos} />
        </li>
      ))}
    </ul>
  );
}

// ...
```

## Congratulations!

You now have a working todo app that has full CRUD functionality that can create, read, update, and delete todos.

You've been able to see how many of the major React concepts work firsthand and you're now in a great position to start building your own React applications.

If you would like to take a look at our final app code, you can see it [here](https://codesandbox.io/s/late-firefly-ker6p).

*Click here to be notified when it opens*

------

![Reed Barger](https://www.freecodecamp.org/news/content/images/size/w100/2021/05/reed-barger-gravatar.jpeg)

#### [Reed Barger](https://www.freecodecamp.org/news/author/reed/)

React developer who loves to make incredible apps. Showing you how at ReactBootcamp.com