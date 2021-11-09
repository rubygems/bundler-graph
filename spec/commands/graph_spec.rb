# frozen_string_literal: true

RSpec.describe "bundle graph" do
  before do
    @org_dir = Dir.pwd
    app_dir = File.join(Dir.pwd, "tmp/bundled_app")
    FileUtils.rm_rf(app_dir)
    FileUtils.mkdir_p(app_dir)
    Dir.chdir(app_dir)
  end

  after do
    Dir.chdir(@org_dir)
  end

  let(:base_gemfile) do
    bundler_graph_root = Pathname.new(__dir__).join("..").expand_path

    <<~G.chomp
      source "https://rubygems.org"
      plugin "bundler-graph", :git => #{bundler_graph_root.to_s.inspect}, :ref => "HEAD"
      require File.join(Bundler::Plugin.index.load_paths("bundler-graph")[0], "bundler-graph") rescue nil
    G
  end

  it "graphs gems from the Gemfile" do
    install_gemfile <<-G
      #{base_gemfile}
      gem "rack"
      gem "rack-obama"
    G

    out = run_command "bundle graph"
    expect(out).to include("gem_graph.png")

    out = run_command "bundle graph --format debug"
    expect(out).to eq(strip_whitespace(<<-DOT).strip)
      digraph Gemfile {
      concentrate = "true";
      normalize = "true";
      nodesep = "0.55";
      edge[ weight  =  "2"];
      node[ fontname  =  "Arial, Helvetica, SansSerif"];
      edge[ fontname  =  "Arial, Helvetica, SansSerif" , fontsize  =  "12"];
      default [style = "filled", fillcolor = "#B9B9D5", shape = "box3d", fontsize = "16", label = "default"];
      rack [style = "filled", fillcolor = "#B9B9D5", label = "rack"];
        default -> rack [constraint = "false"];
      "rack-obama" [style = "filled", fillcolor = "#B9B9D5", label = "rack-obama"];
        default -> "rack-obama" [constraint = "false"];
        "rack-obama" -> rack;
      }
      debugging bundle viz...
    DOT
  end

  it "graphs gems that are prereleases" do
    install_gemfile <<-G
      #{base_gemfile}
      gem "rack", "= 1.3.pre"
      gem "rack-obama"
    G

    out = run_command "bundle graph"
    expect(out).to include("gem_graph.png")

    out = run_command "bundle graph --format debug --version"
    expect(out).to eq(strip_whitespace(<<-EOS).strip)
      digraph Gemfile {
      concentrate = "true";
      normalize = "true";
      nodesep = "0.55";
      edge[ weight  =  "2"];
      node[ fontname  =  "Arial, Helvetica, SansSerif"];
      edge[ fontname  =  "Arial, Helvetica, SansSerif" , fontsize  =  "12"];
      default [style = "filled", fillcolor = "#B9B9D5", shape = "box3d", fontsize = "16", label = "default"];
      rack [style = "filled", fillcolor = "#B9B9D5", label = "rack\\n1.3.pre"];
        default -> rack [constraint = "false"];
      "rack-obama" [style = "filled", fillcolor = "#B9B9D5", label = "rack-obama\\n1.0"];
        default -> "rack-obama" [constraint = "false"];
        "rack-obama" -> rack;
      }
      debugging bundle viz...
    EOS
  end

  context "--without option" do
    it "one group" do
      install_gemfile <<-G
        #{base_gemfile}
        gem "activesupport"

        group :rails do
          gem "rails"
        end
      G

      out = run_command "bundle graph --without=rails"
      expect(out).to include("gem_graph.png")
    end

    it "two groups" do
      install_gemfile <<-G
        #{base_gemfile}
        gem "activesupport"

        group :rack do
          gem "rack"
        end

        group :rails do
          gem "rails"
        end
      G

      out = run_command "bundle graph --without=rails:rack"
      expect(out).to include("gem_graph.png")
    end
  end
end
