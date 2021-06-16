# React Cheat Sheet

## Create-react-app

```bash
npx create-react-app myApp
```

Config is created in `package.json`

## Using the State Hook

*Hooks* are a new addition in React 16.8. They let you use state and other React features without writing a class.

The [introduction page](https://reactjs.org/docs/hooks-intro.html) used this example to get familiar with Hooks:

```react
import React, { useState } from 'react';

function Example() {
  // Declare a new state variable, which we'll call "count"  const [count, setCount] = useState(0);
  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}
```

We’ll start learning about Hooks by comparing this code to an equivalent class example.

### Equivalent Class Example

If you used classes in React before, this code should look familiar:

```react
class Example extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      count: 0
    };
  }

  render() {
    return (
      <div>
        <p>You clicked {this.state.count} times</p>
        <button onClick={() => this.setState({ count: this.state.count + 1 })}>
          Click me
        </button>
      </div>
    );
  }
}
```

