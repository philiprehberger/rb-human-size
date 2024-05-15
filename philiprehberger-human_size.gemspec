# frozen_string_literal: true

require_relative 'lib/philiprehberger/human_size/version'

Gem::Specification.new do |spec|
  spec.name = 'philiprehberger-human_size'
  spec.version = Philiprehberger::HumanSize::VERSION
  spec.authors = ['philiprehberger']
  spec.email = ['philiprehberger@users.noreply.github.com']

  spec.summary = 'Bidirectional byte size formatting with SI and binary units'
  spec.description = 'Format byte counts as human-readable strings (1.5 MB) and parse them back. ' \
                     'Supports SI units (KB, MB, GB) and binary units (KiB, MiB, GiB) with ' \
                     'configurable precision.'
  spec.homepage = 'https://philiprehberger.com/open-source-packages/ruby/philiprehberger-human_size'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/philiprehberger/rb-human-size'
  spec.metadata['changelog_uri'] = 'https://github.com/philiprehberger/rb-human-size/blob/main/CHANGELOG.md'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/philiprehberger/rb-human-size/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG.md']
  spec.require_paths = ['lib']
end
