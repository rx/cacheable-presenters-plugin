require 'voom/presenters'

def load_presenters(dir, root)
  Voom::Presenters::App.load(dir.to_s, root)
end

def reset_presenters!
  Voom::Presenters::App.reset!
end

def find_pom_by_key(key)
  Voom::Presenters::App[key].call.expand(router: nil)
end
