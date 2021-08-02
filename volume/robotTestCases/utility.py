import sys
import os
import pandas as pd
from tabulate import tabulate


def compare2LogFiles(fileBase, fileToCheck, fileToCheckDir, rootDir):
    try:
        failOrPass = "FAIL"
        reasonToFail = None


        filepath_base = rootDir + "/volume/robotTestCases/testData/" + fileBase
        filepath_check = rootDir + "/volume/" + fileToCheckDir + "/" + fileToCheck

        print("# Starting to compare..")
        print("=> %s and %s"%(filepath_base, filepath_check))

        df1 = pd.read_csv(filepath_base, names=['lineContent'])
        df2 = pd.read_csv(filepath_check, names=['lineContent'])

        if (df1.equals(df2)):
            failOrPass = "PASS"
            reasonToFail = "* Comparison result : The 2 files are identical"
            # print ("* Comparison result : The 2 files are identical")
            return failOrPass

        df1['lineNumber'] = df1.index
        df2['lineNumber'] = df2.index

        frames = [df1, df2]
        df_merged = pd.concat(frames)
        df_merged['lineNumber'] = df_merged.index

        #merge 2 dataframes and merge -> Delete duplicates
        df_unique = df_merged.drop_duplicates(keep=False)
        pd.set_option('expand_frame_repr', False)
        pd.set_option('display.max_rows', None)

        #Since this df shows all unique lines which is double of all different lines.
        numErrors = int(len(df_unique)/2)
        reasonToFail = "* Comparison result : Number of unmatched row is " + str(numErrors)

        #Create df with the 1st half
        df_unique_half = df_unique.head(numErrors)
        # Create df with the last half
        df_unique_lastHalf = df_unique.tail(numErrors)
        df_merged_sideByside =  pd.concat([df_unique_half.reset_index(drop=1).add_suffix('_in'),
                   df_unique_lastHalf.reset_index(drop=1).add_suffix('_out')], axis=1).fillna('')

        #Print the result using tabulate library to show table form side by side
        print ("\n##### Detailed Result #### ")
        print('* Total number of unmatched row:', numErrors)
        print(tabulate(df_merged_sideByside[['lineNumber_in', 'lineContent_in', 'lineContent_out']], headers='keys', tablefmt='fancy_grid'))
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
        print ("Unexpected error:", sys.exc_info()[0])
        reasonToFail = "Unexpected error"
    finally:
        return failOrPass, reasonToFail

def  fail_if_stringContains_FAIL_None_old (varString):
    print ("The input string is ", varString )
    if ('FAIL' in varString) or ('None' in varString) :
        return 'FAIL'
    else:
        return 'PASS'

def  fail_if_stringContains_FAIL_None (target_1, passOrFail_1, reason_1, target_2, passOrFail_2, reason_2):

    combinedStaring_passOrFail = passOrFail_1 + passOrFail_2
    combinedStaring_reason = target_1 + " : " + reason_1 + "\n" + target_2 + " : " + reason_2
    if ('FAIL' in combinedStaring_passOrFail) or ('None' in combinedStaring_passOrFail) :
        return 'FAIL', combinedStaring_reason
    else:
        return 'PASS', combinedStaring_reason


def deleteTargetLogFiles(rootDir):
    logFileName = "events.log"

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


if __name__ == "__main__":
    baseDir = 'D:\young\\temp\\'
    filepath_check = baseDir + 'events.log'
    filepath_base = baseDir + 'large_1M_events.log'
    compare2LogFiles(filepath_base, filepath_base)
