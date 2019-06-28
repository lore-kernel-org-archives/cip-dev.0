From: wagi@monom.org (Daniel Wagner)
Date: Fri, 28 Jun 2019 10:27:51 +0200
Subject: [cip-dev] [RFC/RFT] -cip-rt kernels for review/testing
In-Reply-To: <564b1c37-083e-5b56-7e56-abc4b9ddb7bd@siemens.com>
References: <20190623203704.GA12734@amd>
	<564b1c37-083e-5b56-7e56-abc4b9ddb7bd@siemens.com>
Message-ID: <25cee49e-ea67-0e23-87b9-6198bd5749f4@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

On 6/24/19 8:28 AM, Jan Kiszka wrote:
> On 23.06.19 22:37, Pavel Machek wrote:
>> v4.19.50-rt22-cip3-rebase was reasonably easy to do, as -cip1 was
>> empty. v4.4.179-rt181-cip34-rebase was more interesting.

Yep, the v4.4.179 brought some conflicts. Have you compared with my 
merge for v4.4-rt? Not sure if I understand your worklfow correctly. It 
looks like you used for the rebase branches the upstream -rt patchset 
and merged the cip branch. Is this correct?

What I did for the v4.4-cip-rt and v4.19-cip-rt is following

- initial setup (only once):

took the latest cip release and applied the current/matching -rt patcheset

- regulare update:

$ cd v4.4-rt
$ git tag -l 'v4\.4\.*' --sort=v:refname | tail
$ git merge v4.4.120      [fixup conflicts]

# do some testing (this is on Linutronix -rt test infrastrucure)
$ git push lxcvs -f --follow-tag HEAD:stable-maintenance-4.4.y-rt

$ srt commit
$ srt tag

$ cd v4.4-rt-rebase
$ git rebase -i v4.4.120  [fixup conflicts]
$ srt commit
$ srt tag

# check if the -rt-rebase branch is identical to v4.4-rt
$ git diff v4.4-rt

$ srt create v4.4.115-rt130 v4.4.120-rt135
$ srt sign v4.4.115-rt130 v4.4.120-rt135
$ srt upload v4.4.115-rt130 v4.4.120-rt135
$ srt push v4.4.115-rt130 v4.4.120-rt135

# XXX push missing tags
$ git push origin v4.4.115-rt131 v4.4.116-rt132 v4.4.118-rt133 
v4.4.119-rt134

$ srt announce v4.4.115-rt130 v4.4.120-rt135 > ../announce-rt
$ cat ../announce-rt | msmtp -t --

The srt tool is available here: https://github.com/igaw/stable-rt-tools
It a few lines around git to make the steps consist. It is based on 
Steven Rostedt workflow. Tom Zanussi (also -rt stable maintainer) and I 
am using the tool to maintain the -rt trees.

>> Trees are at kernel.org:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-cip.git/log/?h=v4.4.179-rt181-cip34-rebase 
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-cip.git/log/?h=v4.19.50-rt22-cip3-rebase 
>>
>>
>> Basically untested. Could I ask for reviews and testing?

-  git fetch pavel --tags
 From git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-cip
  ! [rejected]                  v4.4.176-cip31        -> v4.4.176-cip31 
(would clobber existing tag)
  ! [rejected]                  v4.4.176-cip31-rebase -> 
v4.4.176-cip31-rebase  (would clobber existing tag)


Was v4.4.176-cip31 rebased?

- tag pattern used to be "v4.4.[0-9]+-cip[0-9]+-rt[0-9]+", it's now
   "v4.4.[0-9]+-rt[0-9]+-cip[0-9]+".

- in the v4.4-rt is still a problem with f01f17d3705b ("mm, vmstat: make 
quiet_vmstat lighter"). It is needed to boot on x86_64 but it breaks on 
NVIDIA's boards, e.g. Jetson. Unfortunately, I don't have a NVIDIA board 
in my lab to figure out what is missing. So I suspect there is a still a 
problem hidden in the current v4.4-rt tree.

>> I know that full preemption does not work on x86-32. I sent
>> "PREEMPT_RT_FULL on x86-32 machine" mail to the lists

I haven't run the v4.4 tree in 32bit so far. I can try if I get it 
booting in my lab.

>> I don't know how to release useful non-rebasing trees. Is someone
>> using those?
> 
> Just like the regular -cip kernel, the -rt version's primary stable feed 
> is merge-based. Rebasing only comes out of the fact that a second patch 
> series is involved, but I doubt many folks use that feed as source. I 
> don't, my colleagues neither (AFAIK).

If it helps, I am going to give a talk at Plubmers on how to maintain 
the -rt trees:


"""
Maintaining out of tree patches over the long term

The PREEMPT_RT patchset is the longest existing large patchset living 
outside the Linux kernel. Over the years, the realtime developers had to 
maintain several stable kernel versions of the patchset. This talk will 
present the lessons learned from this experience, including workflow, 
tooling and release management that has proven over time to scale. The 
workflow deals with upstream changes and changes to the patchset itself. 
Now that the PREEMPT_RT patchset is about the be merged upstream, we 
want to share our toolset and methods with others who may be able to 
benefit from our experience.

This talk is for people who want to maintain an external patchset with 
stable releases.
"""

> Please sync with Daniel Wagner on the workflow options and also on 
> 4.4-rt maintenance.

Hope I could already answer a few question. In summary, have a look at 
stable-rt-tools which is the workflow implemented into a python script.

Thanks,
Daniel
