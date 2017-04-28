From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 28 Apr 2017 12:08:34 +0900
Subject: [cip-dev] [Fuego] Discussion about Fuego unified results format
In-Reply-To: <CAKMC-BVU-K5g2Gf3z3Re5jh3yarB8i1EXN5PD6zGgBDaNLpjPA@mail.gmail.com>
References: <ECADFF3FD767C149AD96A924E7EA6EAF1FA6D432@USCULXMSG03.am.sony.com>
	<m2k26f2bhz.fsf@baylibre.com>
	<003501d2ba48$437ca6e0$ca75f4a0$@toshiba.co.jp>
	<CAKMC-BVU-K5g2Gf3z3Re5jh3yarB8i1EXN5PD6zGgBDaNLpjPA@mail.gmail.com>
Message-ID: <005401d2bfcc$b8d77fd0$2a867f70$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Milo,

> -----Original Message-----
> From: Milo Casagrande [mailto:milo.casagrande at linaro.org]
> Sent: Thursday, April 27, 2017 5:02 PM
> Hi Daniel,
> 
> Kevin pointed me to this discussion and I wanted to reply to a few of
> the points below.

Thanks to both of you.
 
> As a little bit of background: I'm one of the developer behind
> kernelci.org, and I've done most of the work on API and web UI.
> I might be lacking some information or getting some terms not
> correctly, so please bear with me, and in case I would appreciate some
> pointers to specifications/schemas/docs/README that can help me out.

Currently most of the documentation is outdated and we are still fixing
the original proof-of-concept code written by Cogent embedded.

For the topic of this conversation, the closest to the current status is the results.json section at
http://bird.org/fuego/Unified_Results_Format_Project
  
> On Fri, Apr 21, 2017 at 4:37 AM, Daniel Sangorrin
> <daniel.sangorrin@toshiba.co.jp> wrote:
> >
> > Thanks, I checked it a few months ago but not in depth yet. At the time I came
> > to the conclusion that there was a separate schema for each type of test (build,
> > boot,..). Has that changed or is it a misunderstanding from my side?.
> > Ref: https://api.kernelci.org/schema.html
> > Ref: https://api.kernelci.org/schema-boot.html
> > Ref: https://api.kernelci.org/schema-build.html
> >
> > [Note] I think we would rather have a single generic format for all tests.
> 
> For kernelci.org, builds and boots are a special kind of "test",
> that's why we have always been keeping them separate from everything
> else. Builds and boots are what we started building kernelci.org on.
> After the build and boot phase, a "test" can be reduced to whatever
> else can be run - and gives an output - on a board after it booted
> successfully.

Ok, so my understanding now is that there are multiple schemas (batch, boot, boot_regressions, 
build, build_logs, build_logs_summary, compare, job, lab, report, send, token), some of them 
containing two sub-schemas (GET and POST) but for non kernel build/boot tests we would only
need to care about the 3+3+3 schemas at https://api.kernelci.org/schema-test.html.
Is that correct?

How many individual JSON files would be needed to be generated/POST'ed for a multi test case test suite like LTP.
# For example, suppose  1 testsuite made of 6 test sets with 100 test cases each
# Note: in Fuego we only generate 1 JSON file.

If we make Fuego and KernelCI interact together, Fuego would mainly POST results but
the reporting tool would also GET them.

By the way, where can I find more information about the "non special" tests?
# I can only see kernel build/boot test tabs at https://kernelci.org.
I have prepared a virtual machine with KernelCI and I want to start making experiments
by POST'ing Fuego results from different tests (not just build/boot tests) to KernelCI.
Is that supposed to work out of the box?

> > Actually, the current JSON output goes as follows:
> >
> > testsuite (e.g.: Functional.LTP)
> > --board (e.g. Beaglebone black)
> > ----kernel version (e.g.: CIP kernel 4.4.55 ...)
> > ------spec (e.g.: default or quick)
> > --------build number (like KernelCI build id)
> > ----------groupname <-- we do have groups! (e.g.: 2048b_sector_size)
> > ------------test1 (e.g.: reads)
> > -------------- measurement
> > -------------- reference value (e.g. a threshold of Mb/s)
> > ------------test2 (e.g. writes)
> > ------------test3 (e.g.: re-writes)
> >
> > [Note] We also have the concept of testplans where you can group testsuites
> > and their specs for a specific board. This is quite useful.
> >
> > Apart from this information we also store timestamps, the test raw output,
> > fuego variables (this needs improvements but it will be useful for "replaying" tests),
> > and a developers log (including syslog errors, cat /proc/cpuinfo, ps output etc..).
> 
> We don't store raw outputs or logs directly in the schema, if that's
> what you meant.

Yeah, we don't either. We just package them (something like LAVA's bundles) and
(proof-of-concept work) send them to a central server.
 
> The test schema includes an "attachment" sub-schema that can be used
> to define where those outputs/files are stored. We have a separate
> system (storage.kernelci.org) that is used to "archive" artifacts from
> the build/boot and potentially from the test phases.

It's good to have that decoupling and possibly (?) default to local host when
the user doesn't have a separate storage server.
 
> We don't rely on the build/boot/test system (Jenkins in this case) to
> handle that: we extract what we need and store it where we need it.
> You could even store it somewhere else and point the attachment to the
> correct URL, then it's up to a visualization implementation to handle
> that.
> 
> > I am checking Kernel CI's output schema(s) from the link you sent:
> >
> > 1) parameters: seems to be the equivalent to our specs
> 
> I'm not sure what the "spec" is for Fuego, but the "parameters" for us
> is used to store something like the environment variables set and
> their values, command line options passed...

Yes, exactly the same. But we are not storing the spec in the results yet, just
the name of the spec. We will have to send the spec as well somehow
when we want to share the results with a centralized server. 
 
> > 2) minimum, maximum, number of samples, samples_sum, samples_swr_sum: we don't store
> >      information that can be inferred from the data at the moment, just calculate it when making a report.
> 
> I don't remember when we introduced those (keep in mind that they are
> not required fields), but the idea was to store some statistical
> analysis directly into the tests.
> I think the "samples_sqr_sum" description is a little bit off though.
> 
> > 5) kvm_guest: this would be just another board name in Fuego, so we don't include such specific parameter.
> 
> It's not required field, but needed for us since we might run tests on
> KVM and need to keep track where exactly they ran.

        "kvm_guest": {
            "type": "string",
            "description": "The name of the KVM guest this test case has been executed on"
        },

Do you think it could be changed to something more generic such as "the board" or "the node"?
By the way, is KernelCI a community project with for example a mailing list where I can send patches and there is a reviewer etc..?

> > 6) definition_uri: the URI is inferred from the data in our case right now. In other words, the folder where the
> >      data is stored is a combination of the board's name, testname, spec, build number etc..
> > 7) time: this is stored by jenkins, but not in the json output. We will probably have to analyze the
> >      Jenkins build output XML, extract such information and add it to the JSON output. I think this work is already
> >      done by Cai Song, so I want to merge that.
> 
> >From what I could see and understand, Fuego is tightly coupled with
> Jenkins: kernelci.org is not (or at least tries not to as much as it
> can).
> kernelci.org doesn't know where the builds are running, nor where the
> boots are happening and which systems are being used to do all that.
> The same can be extended to the test phase: they can be run anywhere
> on completely different systems.
> 
> Potentially we can swap Jenkins out and use another build system,
> that's why we need to keep track of measurements like this one because
> we don't rely on the other systems.

Sorry, I was wrong about '7', we already measure build duration and the 
whole test duration in our scripts.

>From the architecture point of view, Fuego does not depend on Jenkins anymore. 
There are some quirks that need to be fixed in the implementation, but basically
we are going to be decoupled like KernelCI. In fact we will be able to run and 
report results from the command line without GUIs or web applications.
 
> > 8) attachments: we have something similar (success_links and fail_links in the spec) that are used to present a link on
> >      the jenkins interface. This way the user can download the results (e.g.: excel file, a tar.gz file, a log file, a png..).
> 
> See above for the "attachment". I'm not sure it's the same as
> "[success|fail]_links", but I'm lacking some background info here.

It's kind of similar but at the moment we are assuming that the files are stored in the host so the links
are to local files. This is fine for most people, but probably we should support external links like KernelCI does with
the storage server in the future.

> > 9) metadata: we don't have this at the moment, but I think it's covered by the testlog, devlog, and links.
> > 10) kernel: we have this as fwver (we use the word firmware since it doesn't need to be the linux kernel)
> > 11) defconfig: we do not store this at the moment. In the kernel_build test the spec has a "config" parameter that
> >   has similar functionality though.
> > 12) arch: this is stored as part of the board parameters (the board files contain other variables
> >    such as the toolchain used, path used for tests, etc..)
> 
> We extract all those values from either the build or the boot data,
> it's mostly needed for searching/indexing capabilities.
> The test schemas are probably a little bit tightly coupled with our
> concepts of build and boot.
> 
> > 13) created_on: this information is probably stored inside jenkins.

Actually, this will be stored in the variable FUEGO_HOST.

> > 14) lab_name: this seems similar to the information that Tim wants to add for sharing tests.
> > 15) test_set: this looks similar to fuego's groupnames.
> > 16) test_case: we have test cases (called test in Fuego, although there is a naming inconsistency
> >   issue in Fuego at the moment) support. However I want to add the ability to define or "undefine"
> >   which test cases need to be run.
> 
> Hmmm... not sure I get what you meant here.

Sorry, the "undefine" thing was somehow unrelated. I was just mentioning that
specs (Kernel CI's parameters) should allow blacklisting some of the test cases.
Nothing related to the schema.

> All the test schemas in kernelci.org are used to provide the results
> from test runs, not to define which tests need to be run or not.
> In our case that is up to the test definitions, the test runners or
> whoever runs the tests. What we are interested in, at least for
> kernelci.org, are the results of those runs.
> 
> > The reporting part in Fuego needs to be improved as well, I will be working on this soon.
> > I think that reports should be based on templates, so that the user can prepare his/her
> > own template (e.g.: in Japanese) and Fuego will create the document filling the gaps
> > with data.
> The email we send out are based on some custom templates (built with
> Jinja) that potentially could be translated into different languages:
> we are using gettext to implement plurals/singular, and most of the
> strings in the email template are marked for translation.
> 
> We never had the use case for that (nor the time/resources do do
> that), but with some work - and some translations - it could be done.

Actually, what you have is fine I think. KernelCI has a GET interface, so the local reporting
tool would just download the necessary results and create the report according
to a template provided by the user. If we have the same GET interface, we can share
the reporting tool.

> >   + Option 2: Use the KernelCI web app
> >      -> KernelCI web app is a strong option but we may need to extend
> >           some parts. In that case, I would like to work with you and the KernelCI
> >           maintainers because it is too complex to maintain a fork.
> >           Fuego could have a command like "ftc push -f kernelci -s 172.34.5.2" where the
> >           internal custom format would be converted to KernelCI schema and POST'ed
> >      -> The web app must be portable and easy to deploy. We don't want only one
> >            single server on the whole Internet. This work at the CIP project is very
> >            valuable in this sense: https://github.com/cip-project/cip-kernelci
> 
> We have plans to move everything to a container based approach, and
> that should be more portable than it is now.

That's great. 

Actually, it's already virtualized here (the previous link was outdated).
https://gitlab.com/cip-project/board-at-desk-single-dev

I already got KernelCI working with that, but I had to make a small modification to
KernelCI because I work behind a proxy.

Let me summarize some action items
  - I will try POST'ing Fuego's kernel_build results to KernelCI (I will use CIP's board-at-desk-single-dev VM)
  - Is the generic test interface ready to use out of the box?
    + If not, is the KernelCI project willing to (or have time/resources for) patching or reviewing patches?
    + if yes, I will try POST'ing Fuego's Dhrystone and Bonnie results
  - Will  the KernelCI project collaborate on the board-at-desk-single-dev VM or create a new container?
    + If creating a new one, do you have enough resources or can you give us an approximate date?

Thanks,
Daniel
