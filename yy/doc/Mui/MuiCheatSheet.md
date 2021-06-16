# Material Ui

## Global CSS

If you are using the [CssBaseline](https://material-ui.com/components/css-baseline/) component to apply global resets, it can also be used to apply global styles. For instance:
```React
const theme = createMuiTheme({
  overrides: {
    MuiCssBaseline: {
      '@global': {
        html: {
          WebkitFontSmoothing: 'auto',
        },
      },
    },
  },
});

// ...
return (
  <ThemeProvider theme={theme}>
    <CssBaseline />
    {children}
  </ThemeProvider>
);
```

## Default props

You can change the default props of all the Material-UI components. A `props` key is exposed in the `theme` for this use case.

```react
const theme = createMuiTheme({
  props: {
    // Name of the component ⚛️
    MuiButtonBase: {
      // The default props to change
      disableRipple: true, // No more ripple, on the whole application 💣!
    },
  },
});
```

## Custom CSS classes

Combine JSS generated class names with global ones.

```react
import React from 'react';
import clsx from 'clsx';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles({
  root: {
    '&.root': {
      height: 100,
      width: 100,
      backgroundColor: 'blue',
    },
    '& .child': {
      height: 8,
      backgroundColor: 'red',
    },
  },
});

export default function HybridCss() {
  const classes = useStyles();

  return (
    <div className={clsx(classes.root, 'root')}>
      <div className="child" />
    </div>
  );
}
```

