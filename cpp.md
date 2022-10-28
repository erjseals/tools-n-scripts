# C++ Notes

## Name Lookup
[Name lookup is the procedure by which a name, when encountered in a program, is associated with the declaration that introduced it.](https://en.cppreference.com/w/cpp/language/lookup)

### [Qualified Lookup](https://en.cppreference.com/w/cpp/language/qualified_lookup)
A qualified name is a name that appears on the right hand side of the scope resolution operator :: (see also [qualified identifiers](https://en.cppreference.com/w/cpp/language/identifiers#Qualified_identifiers)). A qualified name may refer to a

* class member (including static and non-static functions, types, templates, etc)
* namespace member (including another namespace)
* enumerator

If there is nothing on the left hand side of the ::, the lookup considers only declarations made in the global namespace scope (or introduced into the global namespace by a [using declaration](https://en.cppreference.com/w/cpp/language/namespace)). This makes it possible to refer to such names even if they were hidden by a local declaration:

### [Unqualified Lookup](https://en.cppreference.com/w/cpp/language/unqualified_lookup)
For an unqualified name, that is a name that does not appear to the right of a scope resolution operator ::, name lookup examines the [scopes](https://en.cppreference.com/w/cpp/language/scope) as described below, until it finds at least one declaration of any kind, at which time the lookup stops and no further scopes are examined. (Note: lookup from some contexts skips some declarations, for example, lookup of the name used to the left of :: ignores function, variable, and enumerator declarations, lookup of a name used as a base class specifier ignores all non-type declarations)

For the purpose of unqualified name lookup, all declarations from a namespace nominated by a [using directive](https://en.cppreference.com/w/cpp/language/namespace) appear as if declared in the nearest enclosing namespace which contains, directly or indirectly, both the using-directive and the nominated namespace.

Unqualified name lookup of the name used to the left of the function-call operator (and, equivalently, operator in an expression) is described in [argument-dependent lookup](https://en.cppreference.com/w/cpp/language/adl).