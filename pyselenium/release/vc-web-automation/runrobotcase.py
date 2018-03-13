#!/usr/bin/env python
# -*- coding:UTF-8 -*-

import os


def run_all_case(suite_path=None, argument_file_path=None):
    arg_file = "--argumentfile ./argfile "
    re_outputfile = "rerun.xml"
    if argument_file_path:
        arg_file ="--argumentfile %s " % argument_file_path
    suite_name = "./vTopCenterWebCase"
    result_dir = "../runresultdir"
    if suite_path:
        suite_name = suite_path
    cmd = "robot --outputdir %s " % result_dir
    cmd += arg_file + suite_name
    print "Run test cases"
    first_run = os.system(cmd)
    if first_run != 0:
        try:
            re_cmd = "robot --rerunfailed %s/output.xml " % result_dir
            re_cmd += "--outputdir %s " % result_dir
            re_cmd += "--output %s " % re_outputfile
            re_cmd += suite_name
            print "Run the wrong test case"
            os.system(re_cmd)
        finally:
            merge_cmd = "rebot  --outputdir %s " % result_dir
            merge_cmd += "--merge %s/output.xml %s/%s " % (result_dir, result_dir, re_outputfile)
            print "Consolidate test results report"
            os.system(merge_cmd)

if __name__ == "__main__":
    run_all_case()

