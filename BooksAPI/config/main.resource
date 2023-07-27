*** Settings ***
Documentation    Setup responsavel por importar todas as dependencias do framework.

Library          RequestsLibrary    # referente a biblioteca HTTP RequestsLibrary (Python)
Library          Collections        # biblioteca nativa do Robot

Resource         ../resource/base_keywords.robot
Resource         ../resource/base.robot
