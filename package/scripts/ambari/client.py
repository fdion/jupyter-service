import ambari_helpers as helpers
from resource_management import ClientComponentHasNoStatus, Execute, Script


class Client(Script):
    def install(self, env):
        self.configure(env)
        import client_params as params

        # Add repos to yum
        helpers.add_repos()
        self.install_packages(env)

        for command in params.commands:
            Execute(command)

    def status(self, env):
        raise ClientComponentHasNoStatus()

    def configure(self, env):
        import client_params as params

        env.set_params(params)


if __name__ == "__main__":
    Client().execute()
