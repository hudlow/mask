// Copyright 2024 Dan Hudlow
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

 expression = e:path|1.., ","|
              {
                /* : string[] */
                return e.flat();
              }

       path = p:$(segment|1.., "."|) t:terminal?
              {
                /* : string | string[] */
                if (t === null) return p;
                else if (typeof t === "string") return p + t;
                else return t.map((child: string) => p + '.' + child);
              }

   terminal = "." /
              "{}" /
              "{" @expression "}"

    segment = $(name "[]") /
              name

       name = $(
                "$"?
                [a-zA-Z]
                [a-zA-Z0-9]*
                ("_" [a-zA-Z0-9]+)*
              )
