import json
import sys
import os
import time

import pandas as pd
from tabulate import tabulate
from subprocess import check_output

rootDir = os.environ["ENV_ROOTDIR"]

def compare2LogFiles(fileBase, fileToCheck, fileToCheckDir):
    try:
        failOrPass = "FAIL"
        reasonToFail = None
        global  rootDir



        #filepath_base = rootDir + "/volume/robotTestCases/testData/" + fileBase
        filepath_base = rootDir + "/assignment/agent/inputs/" + fileBase
        filepath_check = rootDir + "/volume/" + fileToCheckDir + "/" + fileToCheck

        print("# Starting to compare 2 files as follows..")
        print("=> %s" % (filepath_base))
        print("=> %s" % (filepath_check))

        # Import files to dataframe -> Add column name for rows.
        df1 = pd.read_csv(filepath_base, names=['lineContent'])
        df2 = pd.read_csv(filepath_check, names=['lineContent'])

        if (df1.equals(df2)):
            failOrPass = "PASS"
            reasonToFail = "* Comparison result : The 2 files are identical"
            return failOrPass

        # Change the index to string "lineNum"
        df1['lineNum'] = df1.index
        df2['lineNum'] = df2.index
        df_merged = pd.merge(df1, df2, how='outer', indicator=True)

        # Drop duplicates based on lineContent
        df_unique = df_merged.drop_duplicates(subset=['lineContent'], keep=False)

        # Get the rows with unmatched in and out
        df_unique_in = df_unique[df_unique['_merge'].str.contains("left_only")]
        totalNumberOfRowsIn = len(df1)
        totalNumberOfRowsOut = len(df2)
        numErrors = len(df_unique_in)
        #This is needed as a return value
        reasonToFail = "* Comparison result : Number of unmatched row is " + str(numErrors)
        df_unique_out = df_unique[df_unique['_merge'].str.contains("right_only")]

        # Merge side by side for etter view
        df_merged_sideByside = pd.concat([df_unique_in.reset_index(drop=1).add_suffix('_in'),
                                          df_unique_out.reset_index(drop=1).add_suffix('_out')], axis=1)

        # Print the result using tabulate library to show table form side by side
        print("\n##### Detailed Result #### ")
        print('* In: Total number of rows for %s   : %s'%(fileBase,totalNumberOfRowsIn))
        print('* Out: Total number of rows for %s  : %s'%(fileToCheck, totalNumberOfRowsOut))
        print('* Total number of unmatched rows:', numErrors)
        # The following Create bit output.xml so decide not to use at the moment until finding solution.
        # print(tabulate(df_merged_sideByside[
        #                    ['lineNum_in', 'lineContent_in', "_merge_in", "lineNum_out", 'lineContent_out',
        #                     "_merge_out"]], headers='keys', tablefmt='fancy_grid'))
        # Creating csv file for the result -> Save it to .../volume/robotTestCases/results/ directory.

        dateAndTime= time.strftime("%Y%m%d_%H%M%S")
        fileBase = "compareResult_" + fileBase + "_" + fileToCheckDir + "_" + dateAndTime + ".csv"
        fileBase = rootDir + "/volume/robotTestCases/results_csv/" + fileBase
        print('* Exporting the result to :', fileBase)
        df_merged_sideByside.to_csv(fileBase)


    except FileNotFoundError as e:
        print("File not found({0}): {1}".format(e.errno, e.strerror))
        reasonToFail = "FileNotFoundError"
    except pd.errors.EmptyDataError as e:
        print("No data({0}): {1}".format(e.errno, e.strerror))
        reasonToFail = "No data"
    except pd.errors.ParserError as e:
        print("Parse error({0}): {1}".format(e.errno, e.strerror))
        reasonToFail = "Parse error"
    except:  # handle other exceptions such as attribute errors
        print("Unexpected error:", sys.exc_info()[0])
        reasonToFail = "Unexpected error"
    finally:
        return failOrPass, reasonToFail



def  fail_if_stringContains_FAIL_None (target_1, passOrFail_1, reason_1, target_2, passOrFail_2, reason_2):

    combinedStaring_passOrFail = passOrFail_1 + passOrFail_2
    combinedStaring_reason = target_1 + " : " + reason_1 + "\n" + target_2 + " : " + reason_2
    if ('FAIL' in combinedStaring_passOrFail) or ('None' in combinedStaring_passOrFail) :
        return 'FAIL', combinedStaring_reason
    else:
        return 'PASS', combinedStaring_reason


def deleteTargetLogFiles():
    logFileName = "events.log"
    global rootDir

    try:
        logfile_target_1 = rootDir + "/volume/target_1/" + logFileName
        logfile_target_2 = rootDir + "/volume/target_2/" + logFileName

        filesToDelete = [logfile_target_1, logfile_target_2]

        for fileName in filesToDelete:
            if os.path.exists(fileName):
                os.remove(fileName)
                print("%s has been deleted" % (fileName))
            else:
                print("%s doesn't exists" % (fileName))

    except FileNotFoundError as e:
        print("File not found({0}): {1}".format(e.errno, e.strerror))
    except:  # handle other exceptions such as attribute errors
        print ("Unexpected error:", sys.exc_info()[0])

def startNodeAgent():
    global rootDir
    agentJS = rootDir + "/assignment/app.js"
    agenDir = rootDir + "/assignment/agent/"
    p = check_output(['node', agentJS, agenDir])
    print(p)

def changeAgent_InputJson_old(fileBase):

    try:
        global rootDir
        agentInputJson = rootDir + "/assignment/agent/inputs.json"
        print("* Aget input.json full path : ", agentInputJson)
        newInput_withPath = rootDir + "/volume/robotTestCases/testData/" + fileBase
        print("* Change agent->input.json->monitor to : ", newInput_withPath)
        with open(agentInputJson, "r") as jsonFile:
            data = json.load(jsonFile)
            data["monitor"] = newInput_withPath

        with open(agentInputJson, "w") as jsonFile:
            jsonFile.write(json.dumps(data))

    except FileNotFoundError as e:
        print("File not found({0}): {1}".format(e.errno, e.strerror))
    except:  # handle other exceptions such as attribute errors
        print ("Unexpected error:", sys.exc_info()[0])

def changeAgent_InputJson(fileBase):

    try:
        global rootDir
        agentInputJson = rootDir + "/assignment/agent/inputs.json"
        print("* Aget input.json full path : ", agentInputJson)
        newInput_withPath = "inputs/" + fileBase
        "inputs/"
        print("* Change agent->input.json->monitor to : ", newInput_withPath)
        with open(agentInputJson, "r") as jsonFile:
            data = json.load(jsonFile)
            data["monitor"] = newInput_withPath

        with open(agentInputJson, "w") as jsonFile:
            jsonFile.write(json.dumps(data))

    except FileNotFoundError as e:
        print("File not found({0}): {1}".format(e.errno, e.strerror))
    except:  # handle other exceptions such as attribute errors
        print ("Unexpected error:", sys.exc_info()[0])

if __name__ == "__main__":
    baseDir = 'D:\young\\temp\\'
    filepath_check = baseDir + 'events.log'
    filepath_base = baseDir + 'large_1M_events.log'
    #compare2LogFiles(filepath_base, filepath_base)
    startNodeAgent()
