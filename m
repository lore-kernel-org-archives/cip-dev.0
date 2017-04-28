From: milo.casagrande@linaro.org (Milo Casagrande)
Date: Fri, 28 Apr 2017 09:31:58 +0200
Subject: [cip-dev] [Fuego] Discussion about Fuego unified results format
In-Reply-To: <005401d2bfcc$b8d77fd0$2a867f70$@toshiba.co.jp>
References: <ECADFF3FD767C149AD96A924E7EA6EAF1FA6D432@USCULXMSG03.am.sony.com>
	<m2k26f2bhz.fsf@baylibre.com>
	<003501d2ba48$437ca6e0$ca75f4a0$@toshiba.co.jp>
	<CAKMC-BVU-K5g2Gf3z3Re5jh3yarB8i1EXN5PD6zGgBDaNLpjPA@mail.gmail.com>
	<005401d2bfcc$b8d77fd0$2a867f70$@toshiba.co.jp>
Message-ID: <CAKMC-BVApZCho81cPJ9sBiQyUZX+PLLuADyy7hmswBR8B-DoOg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, Apr 28, 2017 at 5:08 AM, Daniel Sangorrin
<daniel.sangorrin@toshiba.co.jp> wrote:
>
> Currently most of the documentation is outdated and we are still fixing
> the original proof-of-concept code written by Cogent embedded.
>
> For the topic of this conversation, the closest to the current status is the results.json section at
> http://bird.org/fuego/Unified_Results_Format_Project
>

Thanks! That is a good starting point for me.

> Ok, so my understanding now is that there are multiple schemas (batch, boot, boot_regressions,
> build, build_logs, build_logs_summary, compare, job, lab, report, send, token), some of them
> containing two sub-schemas (GET and POST) but for non kernel build/boot tests we would only
> need to care about the 3+3+3 schemas at https://api.kernelci.org/schema-test.html.
> Is that correct?

Yes, you are correct.
For the general tests, you would only need those schemas.

The POST and GET schemas are slightly different because when you POST
something, we extract data from the database and include what we can
infer into the data you GET. That is true if the test data includes
references to build and/or boot reports.

> How many individual JSON files would be needed to be generated/POST'ed for a multi test case test suite like LTP.
> # For example, suppose  1 testsuite made of 6 test sets with 100 test cases each
> # Note: in Fuego we only generate 1 JSON file.

You can send 1, 2 or 3: it depends on how you want to send the data.
You should have a more general overview here of how it can work:
https://api.kernelci.org/collection-test.html

In case of just 1 JSON payload, everything else is "embedded": you
would include into the test_set array everything else (and the
test_set will itself include all the other tests in the test_case
array). Or you could split it up into 3 separate payloads.

> If we make Fuego and KernelCI interact together, Fuego would mainly POST results but
> the reporting tool would also GET them.

Right now though, to extract the same data, you would need at least 2
GET requests: once you upload everything, in "embedded" mode or even
with 3 separate POSTs, we only include the references to the other
data.

Due to lack of support on the database side, we couldn't do the over
way around and re-embed the data back. Now the database supports that,
but we haven't got around to actually implement it.

> By the way, where can I find more information about the "non special" tests?
> # I can only see kernel build/boot test tabs at https://kernelci.org.

That's the missing part on kernelci.org: we never had the time to
implement a visualization for the general tests.
I have a branch on github where I started to play around with that,
but it never saw the light of day.

> I have prepared a virtual machine with KernelCI and I want to start making experiments
> by POST'ing Fuego results from different tests (not just build/boot tests) to KernelCI.
> Is that supposed to work out of the box?

More or less yes: you would need to create a token for yourself first
in order to be able to POST the results into the database.

> It's good to have that decoupling and possibly (?) default to local host when
> the user doesn't have a separate storage server.

It is possible yes, but that is a detail on the visualization side, at
least from our POV.

If nothing is defined, we default to storage.kernelci.org, but if you
are running locally, you can tweak the frontend config files and make
it so that it will point to "localhost". It will probably need more
logic to build the correct path, but if using the kernelci API to
upload files it has a fixed location.

I think the CIP project with their VMs are already doing something similar.

>         "kvm_guest": {
>             "type": "string",
>             "description": "The name of the KVM guest this test case has been executed on"
>         },
>
> Do you think it could be changed to something more generic such as "the board" or "the node"?

There should already be a "board" field, at least at the "test_suite" level.

We were asked to include those as well in the "test_set" and
"test_case" schemas, but never got around doing it: we don't have that
much traffic on the test data.

We only included it at the "test_suite" level because for us, a suite
with all its sets and test cases will be run for (almost) each
successfully booted board.

> By the way, is KernelCI a community project with for example a mailing list where I can send patches and there is a reviewer etc..?

We don't have a mailing list, but the code is publicly available on
github [1] [2], and you can submit pull requests there.
We will look at them.

> That's great.
>
> Actually, it's already virtualized here (the previous link was outdated).
> https://gitlab.com/cip-project/board-at-desk-single-dev

Yeah, I know the project. :-)
They are doing a slightly different thing from what we have in mind
(plus they include LAVA in the VM). What we wanted to achieve is a
"docker pull" style of packaging.

We have a basic wireframe of how this should be done here:
https://github.com/kernelci/kernelci-docker
We never really tested it, and it might be a little bit more complex
than a simple "docker pull" command: there are many moving parts, but
with Docker compose that should be achievable.

> Let me summarize some action items
>   - I will try POST'ing Fuego's kernel_build results to KernelCI (I will use CIP's board-at-desk-single-dev VM)
>   - Is the generic test interface ready to use out of the box?

It should, yes, but it definitely is not bugs or quirks free.
The more we use it the more we will discover things to tweak and fix.

>     + If not, is the KernelCI project willing to (or have time/resources for) patching or reviewing patches?

We are willing to review patches, it might take a little bit of time
to do though.

>     + if yes, I will try POST'ing Fuego's Dhrystone and Bonnie results
>   - Will  the KernelCI project collaborate on the board-at-desk-single-dev VM or create a new container?
>     + If creating a new one, do you have enough resources or can you give us an approximate date?

We don't really collaborate with them on that, strictly speaking, but
we try to help them whenever we can and whenever they need help.

Our approach with the container is slightly different compared to the
VM one: we are looking at how to "containerize" the system in order to
deploy it, but more "on the cloud" side than "on the desk" side
(although, with Docker, it should be fairly portable).

Ciao.

[1] https://github.com/kernelci/kernelci-frontend
[2] https://github.com/kernelci/kernelci-backend

-- 
Milo Casagrande
Linaro.org <www.linaro.org> ? Open source software for ARM SoCs
