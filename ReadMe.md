Jekyll-Idio
===========

A jekyll tag to pull out certain elements of a file and embed it in your document, inspired by [Idiopidae](https://github.com/zedshaw/idiopidae) and [Dexy](https://github.com/dexy/dexy).

This is useful for building documentation websites using Jekyll.

Installation:

``` bash
gem install specific_install
gem specific_install UCL-RITS/jekyll-idio.git
```

Jekyll _config.yml:

``` yaml
gems: [ jekyll-idio ]
```

Usage:

In your source file:


``` markdown
Consider this code fragment:
{% idio My Fragment, file.rb %}
```

With file.rb as:
``` ruby
# Some ruby
### My Fragment
# Some more ruby
###
# Yet more ruby
```

The file will render

``` markdown
Consider this code fragment:
# Some more ruby
```

Default separators, depending on file extension:

* .cpp, .h, .hpp, .java, .js: \\\
* Otherwise: ###

Custom separators:

_config.yaml:

``` yaml
idio: 
	separator: /* Idio */ # Or whatever
```

Automatic fenced code blocks
----------------------------

With this option, if a file has a recognised file extension, the fragment will automatically be placed in an appropriate markdown fenced code block.

```yaml
idio:
	fenced: true
```