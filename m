From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 21 Apr 2017 11:37:47 +0900
Subject: [cip-dev] [Fuego] Discussion about Fuego unified results format
In-Reply-To: <m2k26f2bhz.fsf@baylibre.com>
References: <ECADFF3FD767C149AD96A924E7EA6EAF1FA6D432@USCULXMSG03.am.sony.com>
	<m2k26f2bhz.fsf@baylibre.com>
Message-ID: <003501d2ba48$437ca6e0$ca75f4a0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Kevin,

> -----Original Message-----
> From: fuego-bounces at lists.linuxfoundation.org [mailto:fuego-bounces at lists.linuxfoundation.org] On Behalf Of Kevin Hilman

> Has anyone looked at the JSON schema we designed for kernelci.org[1]?  I

Thanks, I checked it a few months ago but not in depth yet. At the time I came
to the conclusion that there was a separate schema for each type of test (build,
boot,..). Has that changed or is it a misunderstanding from my side?.
Ref: https://api.kernelci.org/schema.html
Ref: https://api.kernelci.org/schema-boot.html
Ref: https://api.kernelci.org/schema-build.html

[Note] I think we would rather have a single generic format for all tests.

> wasn't involved in the meetings or call, but from what I can see, one
> important thing missing from your current proposal is how to group
> related tests together.  In the schema we did for kCI, you can have test
> cases grouped into test sets, which in turn can be grouped into a test
> suite.  IMO, this is crucial since most tests come as part of a larger
> suite.

Actually, the current JSON output goes as follows:

testsuite (e.g.: Functional.LTP)
--board (e.g. Beaglebone black)
----kernel version (e.g.: CIP kernel 4.4.55 ...)
------spec (e.g.: default or quick)
--------build number (like KernelCI build id)
----------groupname <-- we do have groups! (e.g.: 2048b_sector_size)
------------test1 (e.g.: reads)
-------------- measurement
-------------- reference value (e.g. a threshold of Mb/s)
------------test2 (e.g. writes)
------------test3 (e.g.: re-writes)

[Note] We also have the concept of testplans where you can group testsuites
and their specs for a specific board. This is quite useful.

Apart from this information we also store timestamps, the test raw output,
fuego variables (this needs improvements but it will be useful for "replaying" tests), 
and a developers log (including syslog errors, cat /proc/cpuinfo, ps output etc..).

Rather than the format, for now I want to check that we are not missing
important data. If we keep the data, then we can easily convert it to other
formats. 

I am checking Kernel CI's output schema(s) from the link you sent:

1) parameters: seems to be the equivalent to our specs
2) minimum, maximum, number of samples, samples_sum, samples_swr_sum: we don't store
     information that can be inferred from the data at the moment, just calculate it when making a report.
3) status: at the moment the JSON output is only working for Benchmarks but I am fixing this. Probably
     I will do as Kernel CI and specify PASS, FAIL, SKIP, ERROR (in LTP, I use BROKEN)
4) vcs_commit: until now all tests were in tarballs, but I already added one test (kernel_build) that uses
     git, so I want to store the commit ids too.
5) kvm_guest: this would be just another board name in Fuego, so we don't include such specific parameter.
6) definition_uri: the URI is inferred from the data in our case right now. In other words, the folder where the
     data is stored is a combination of the board's name, testname, spec, build number etc..
7) time: this is stored by jenkins, but not in the json output. We will probably have to analyze the 
     Jenkins build output XML, extract such information and add it to the JSON output. I think this work is already
     done by Cai Song, so I want to merge that.
8) attachments: we have something similar (success_links and fail_links in the spec) that are used to present a link on
     the jenkins interface. This way the user can download the results (e.g.: excel file, a tar.gz file, a log file, a png..).
9) metadata: we don't have this at the moment, but I think it's covered by the testlog, devlog, and links.
10) kernel: we have this as fwver (we use the word firmware since it doesn't need to be the linux kernel)
11) defconfig: we do not store this at the moment. In the kernel_build test the spec has a "config" parameter that
  has similar functionality though.
12) arch: this is stored as part of the board parameters (the board files contain other variables
   such as the toolchain used, path used for tests, etc..)
13) created_on: this information is probably stored inside jenkins.
14) lab_name: this seems similar to the information that Tim wants to add for sharing tests.
15) test_set: this looks similar to fuego's groupnames. 
16) test_case: we have test cases (called test in Fuego, although there is a naming inconsistency 
  issue in Fuego at the moment) support. However I want to add the ability to define or "undefine"
  which test cases need to be run. For example, in LTP we can select
  which groups we want to run (syscalls, fs, SEM, etc..), but we run all of the subtests@the moment.
  I would like to be able to skip some of the tests, or define which ones to execute. 
  [Note] If possible we want tests to automatically detect whether they are compatible with the board or not.

My conclusion is that we are quite close to the kernel CI schemas in terms of information stored.
We need to add a bit more information, and consolidate it. Probably this will take several prototyping
cycles, until all use cases are covered. 

> The kernelci.org project has prototyped this for several testsuites
> (kselftest, hackbench, lmbench, LTP, etc.) and were pushing JSON results
> using this /test API to our backend for awhile.  But nobody got around
> to writing the parsing, reporting stuff yet.

The reporting part in Fuego needs to be improved as well, I will be working on this soon.
I think that reports should be based on templates, so that the user can prepare his/her
own template (e.g.: in Japanese) and Fuego will create the document filling the gaps
with data.
 
> All of that to say the kCI JSON schema has been through through quite a
> bit already, and acually used for several test suites, so I think it
> would be a good idea to start with that and extend it, so combined
> efforts on this JSON test schema could benefit Fuego as well as other
> projects.

At the moment I am thinking about the architecture and how all these efforts
can combine in a win-win manner. So far this is what I'm thinking:

- Local machines
   + Standard server/desktop distributions (redhat, debian..): use avocado (or openqa for example)
       -> output formats: http://avocado-framework.readthedocs.io/en/48.0/ResultFormats.html
   + Embedded cross-compiled custom distributions (e.g.: yocto-based or buildroot based): use Fuego
      -> output formats: custom format that should include all the information necessary. 
           For this format we can use KernelCI schema as a reference, but I'd rather be loosely coupled, 
           so that we can add our own quirks and have some flexibility. 

- Remote boards / board farms / labs
   + Use Fuego combined with LAVA. Jan-Simon added some initial support, but
       we want to improve it.

- Centralized servers for sharing the results of multiple Fuego "stations"
  + Option 1: Use a custom web app
     -> Fuego supports (needs fixing) packaging the results of a test run (ftc package-run)
          and uploading them to a server (ftc put-run). Tim showed us a demo during ELC
          where he developed a prototype web app that displayed the shared results.
  + Option 2: Use the KernelCI web app
     -> KernelCI web app is a strong option but we may need to extend 
          some parts. In that case, I would like to work with you and the KernelCI
          maintainers because it is too complex to maintain a fork.
          Fuego could have a command like "ftc push -f kernelci -s 172.34.5.2" where the 
          internal custom format would be converted to KernelCI schema and POST'ed
     -> The web app must be portable and easy to deploy. We don't want only one 
           single server on the whole Internet. This work at the CIP project is very
           valuable in this sense: https://github.com/cip-project/cip-kernelci
  + Option 3: Use Fuego itself
     -> Fuego is based on Jenkins which is already a server and has many features
          including a REST API and user accounts.
     -> Fuego already supports parsing results into plots,  links each build number, 
          trend graphs with PASS/FAIL results, etc.

Personally I want to concentrate on Option 3 at first because it requires the least effort
and is useful both for local Fuego stations and centralized servers.

But I would be really happy to help on Option 2 as well as on the LAVA support. If possible
I'd rather do this in collaboration with Baylibre , the automotive-grade linux project 
and the CIP project. 

We could start with a small prototype that runs Fuego tests on a Baylibre's LAVA-scheduled board (e.g. Renesas board), 
and then "ftc push" the results into a Baylibre's KernelCI server (I'd probably need some account for that?). 
And next, make sure that it also runs on the CIP LAVA-KernelCI stack.
What do you think? 

# It would be great to discuss this during the next Open Source Summit Japan
# Tim: are there any news regarding to Option 1?

Best regards,
Daniel
