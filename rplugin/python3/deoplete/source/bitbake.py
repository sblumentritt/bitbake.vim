#!/usr/bin/env python3

import subprocess
from deoplete.source.base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        # deoplete related variables
        self.rank = 1000
        self.name = "bitbake"
        self.mark = "[bitbake]"
        self.input_pattern = r"[^\w\s]$"

        self.min_pattern_length = 1
        self.filetypes = ["bitbake"]
        self.vars = {}

        # private member variables
        self._candidates = []


    # only populate the candidates list on source init and save results in
    # private member because the completion list cannot change at runtime
    def on_init(self, context):
        self._candidates += self.vim.call("bitbake#gather_candidates", "task")
        self._candidates += self.vim.call("bitbake#gather_candidates", "variable")
        self._candidates += self.vim.call("bitbake#gather_candidates", "varflag")


    def gather_candidates(self, context):
        return self._candidates
