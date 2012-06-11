# squire-behaviours

These are a collection of community scripts for [Squire][], a loyal companion
willing to follow your every command.

## Installing

Once you have [Squire][] installed, you can drop new behaviours from this
repository right into your generated Squire installation. Just put them in the
`behaviours` directory and add the new behaviours to the
`squire-behaviours.json` file.

Any third-party dependencies for behaviours need to be added to your
`package.json`, otherwise a lot of errors will be thrown during the start up of
your squire.

Re-summon your squire, and you're ready to go.

All the behaviours in this repository are located in
[`src/behaviours`](https://github.com/neocotic/squire-behaviours/tree/master/src/behaviours).

## Writing

If you want to create your very own [Squire][] behaviour the best way is to
take a look at an existing behaviour and see how things are set up. [Squire][]
behaviours are written in [CoffeeScript][], a higher-level implementation of
JavaScript.

Additionally, it's extremely helpful to add [TomDoc][] to the top of each file.
Commands di are extracted from these lines to be displayed in the generic,
`help` command.

Please note that external dependencies are not included in the `package.json`,
so should you wish to include them please include the package name and required
version in the [TomDoc][] comments at the top of your behaviour.

[coffeescript]: http://coffeescript.org
[squire]: http://neocotic.com/squire
[tomdoc]: http://tomdoc.org