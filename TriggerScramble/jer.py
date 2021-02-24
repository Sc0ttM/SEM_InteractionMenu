import os
import sys
import traceback

def usage():
	print('Usage: python FindAndReplace.py [Old String] [New String] ' \
		  '[File Filters(default:".txt,.html,.erb")] [Directory To Check(.)]')

def replaceStringInFile(fileName, oldStringToReplace, newString):

	if not(os.path.isfile(fileName) and os.access(fileName, os.W_OK)):
		print("WARNING: Skipping...File does not exist or and is not writeable:" + fileName)
		return False

	fileUpdated = False

	# credit/taken/adapted from: http://stackoverflow.com/a/4128194
	# Read in old file
	with open(fileName, 'r') as f:
		newlines = []
		for line in f.readlines():
			if (oldStringToReplace in line) :
				fileUpdated = True
			line = line.replace(oldStringToReplace, newString)
			newlines.append(line)

	# Write changes to same file
	if fileUpdated :
		print("String Found and Updating File: " + fileName)
		try:
			with open(fileName, 'w') as f:
				for line in newlines:
					f.write(line)
		except:
			print('ERROR: Cannot open/access existing file for writing: ' + fileName)

	return fileUpdated

def main():

	try:

		DEFAULT_PATH = '.'

		if len(sys.argv) < 3:
			usage()
			# old/new string required parameters, exit if not supplied
			sys.exit(-1)
		else:
			oldString = sys.argv[1]
			newString = sys.argv[2]

			patterns = ['.lua']

			path = DEFAULT_PATH

		print('[Old String]         : ' + oldString) 
		print('[New String]         : ' + newString)
		print('[File Filters]       : ' + ', '.join(patterns))
		print('[Directory To Check] : ' + path)

		if not os.path.exists(path):
			raise Exception("Selected path does not exist: " + path)

		# Walks through directory structure looking for files matching patterns
		matchingFileList = \
			[os.path.join(dp, f) \
				for dp, dn, filenames in os.walk(path) \
					for f in filenames \
						if os.path.splitext(f)[1] in patterns]

		print('Files found matching patterns: ' + str(len(matchingFileList)))
		fileCount = 0
		filesReplaced = 0
		
		for currentFile in matchingFileList:
		
			fileCount+=1
			fileReplaced = replaceStringInFile(currentFile, oldString, newString)
			if fileReplaced:
				filesReplaced+=1

		print("Total Files Searched         : " + str(fileCount))
		print("Total Files Replaced/Updated : " + str(filesReplaced))
	
	except Exception as err:
		print(traceback.format_exception_only(type(err), err)[0].rstrip())
		sys.exit(-1)

if __name__ == '__main__':
	main()