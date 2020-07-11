Precious::App.set(:default_markup, :asciidoc)

require 'asciidoctor-bibtex'

GitHub::Markup.markups.reject! {|_name, markup| markup.regexp.to_s == '(?-mix:adoc|asc(iidoc)?)' }

GitHub::Markup.markup(:asciidoc, :asciidoctor, /adoc|asc(iidoc)?/, ["AsciiDoc"]) do |filename, content, options: {}|
  attributes = {
    'showtitle' => '@',
    'idprefix' => '',
    'idseparator' => '-',
    'sectanchors' => nil,
    'env' => 'github',
    'env-github' => '',
    'source-highlighter' => 'html-pipeline',
    'bibtex-file' => '/wiki/Bibliographie/Bibliothek.bib',
    'bibtex-sytle' => 'din-1505-2-numeric',
    'bibtex-locale' => 'de-DE'
  }
  if filename
    attributes['docname']       = File.basename(filename, (extname = File.extname(filename)))
    attributes['docfilesuffix'] = attributes['outfilesuffix'] = extname
  else
    attributes['outfilesuffix'] = '.adoc'
  end
  Asciidoctor::Compliance.unique_id_start_index = 1
  Asciidoctor.convert(content, :safe => :safe, :attributes => attributes)
end