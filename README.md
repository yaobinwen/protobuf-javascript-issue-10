# protobuf-javascript: Try to reproduce "'proto' is not defined"

## Overview

This repository aims to reproduce the "'proto' is not defined" error as described in [_ReferenceError: proto is not defined #10_](https://github.com/protocolbuffers/protobuf-javascript/issues/10) to help the developers figure out whether there is a bug and, if there is, how to fix it.

There two sub-directories:

- `noejs` is a `node.js` native app that cannot reproduce the error.
- `react-app` is a React.js app that can reproduce the error.

I'll first mention the other existing work in the next section and then describe how to use these two apps.

## Other work

The issue [1] [_Failed to compile. 'proto' is not defined (also 'COMPILED') #447_](https://github.com/grpc/grpc-web/issues/447) in `grpc-web` mentions a similar problem that used TypeScript. The quick workaround was to disable `eslint` as mentioned [in this comment](https://github.com/grpc/grpc-web/issues/447#issuecomment-459122012). Others in the discussion also provided alternative workarounds. See [this](https://github.com/grpc/grpc-web/issues/447#issuecomment-460420957), [this](https://github.com/grpc/grpc-web/issues/447#issuecomment-491628171), [this](https://github.com/grpc/grpc-web/issues/447#issuecomment-564285432), [this](https://github.com/grpc/grpc-web/issues/447#issuecomment-568559394), and [this](https://github.com/grpc/grpc-web/issues/447#issuecomment-586668982).

The issue also mentions the Pull Request [_Disable static checkers on generated js files #752_](https://github.com/grpc/grpc-web/pull/752). But note that this PR is for `grpc-web` so it only fixes the output of `--grpc-web_out` but not `--js_out`.

But [1] gave me the hint to try to disable `eslint` in the React.js app and that did work around the issue.

## How to use

### Environment

My environment:
- Ubuntu 18.04 Desktop
- `npm`: 6.14.15
- `yarn`: 1.22.15
- `node` (or `nodejs`): 14.18.2
- `google-protobuf`: 3.19.4

### `nodejs`

`cd` into the sub-directory `nodejs` and run `run.sh`. This should print `good` at the end and doesn't report any error.

### `react-app`

There are two shell scripts:
- `run-npm.sh`
- `run-yarn.sh`

Running `run-npm.sh` produced the following output (which suggests `eslint` might be the cause):

```
Failed to compile.

[eslint] 
src/foo_pb.js
  Line 26:1:    'proto' is not defined     no-undef
  Line 29:15:   'proto' is not defined     no-undef
  Line 30:20:   'COMPILED' is not defined  no-undef
  Line 31:3:    'proto' is not defined     no-undef
  Line 46:1:    'proto' is not defined     no-undef
  Line 47:10:   'proto' is not defined     no-undef
  Line 60:1:    'proto' is not defined     no-undef
  Line 78:1:    'proto' is not defined     no-undef
  Line 80:17:   'proto' is not defined     no-undef
  Line 81:10:   'proto' is not defined     no-undef
  Line 92:1:    'proto' is not defined     no-undef
  Line 116:1:   'proto' is not defined     no-undef
  Line 118:3:   'proto' is not defined     no-undef
  Line 130:1:   'proto' is not defined     no-undef
  Line 146:1:   'proto' is not defined     no-undef
  Line 152:1:   'proto' is not defined     no-undef
  Line 157:29:  'proto' is not defined     no-undef

Search for the keywords to learn more about each error.
WARNING in [eslint] 
src/App.js
  Line 4:7:  'proj' is assigned a value but never used  no-unused-vars

src/foo_pb.js
  Line 12:14:  The Function constructor is eval     no-new-func
  Line 61:7:   'f' is defined but never used        no-unused-vars
  Line 80:13:  Missing '()' invoking a constructor  new-parens

ERROR in [eslint] 
src/foo_pb.js
  Line 26:1:    'proto' is not defined     no-undef
  Line 29:15:   'proto' is not defined     no-undef
  Line 30:20:   'COMPILED' is not defined  no-undef
  Line 31:3:    'proto' is not defined     no-undef
  Line 46:1:    'proto' is not defined     no-undef
  Line 47:10:   'proto' is not defined     no-undef
  Line 60:1:    'proto' is not defined     no-undef
  Line 78:1:    'proto' is not defined     no-undef
  Line 80:17:   'proto' is not defined     no-undef
  Line 81:10:   'proto' is not defined     no-undef
  Line 92:1:    'proto' is not defined     no-undef
  Line 116:1:   'proto' is not defined     no-undef
  Line 118:3:   'proto' is not defined     no-undef
  Line 130:1:   'proto' is not defined     no-undef
  Line 146:1:   'proto' is not defined     no-undef
  Line 152:1:   'proto' is not defined     no-undef
  Line 157:29:  'proto' is not defined     no-undef

Search for the keywords to learn more about each error.

webpack compiled with 1 error and 1 warning
```

Running `run-yarn.sh` produced the same output as `run-npm.sh`.
