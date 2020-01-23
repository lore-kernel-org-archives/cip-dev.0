From: punit1.agrawal@toshiba.co.jp (Punit Agrawal)
Date: Thu, 23 Jan 2020 16:34:50 +0900
Subject: [cip-dev] RESUME REQUEST: [cip-core] Package Proposal #1
	(Security packages)
References: <OSAPR01MB23880B5470CDE5D534181CF5DF310@OSAPR01MB2388.jpnprd01.prod.outlook.com>
 <87a76ih15g.fsf@kokedama.swc.toshiba.co.jp>
 <TYAPR01MB2399B94CD0E5825B65F6D673DF0D0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
Message-ID: <877e1imxr9.fsf@kokedama.swc.toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Thank you for your comments, Yoshida-san. Follow up comments inline.

Kento Yoshida <kento.yoshida.wz@renesas.com> writes:

> Hello and thank you for your comment, Punit,
>
>>-----Original Message-----
>>From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>>Sent: Monday, January 20, 2020 7:29 PM
>>To: Kento Yoshida <kento.yoshida.wz@renesas.com>
>>Cc: cip-dev at lists.cip-project.org; kazuhiro3.hayashi at toshiba.co.jp;
>>cip-security at lists.cip-project.org
>>Subject: Re: [cip-dev] RESUME REQUEST: [cip-core] Package Proposal #1 (Security
>>packages)
>>
>>Hello Yoshida-san,
>>
>>Kento Yoshida <kento.yoshida.wz@renesas.com> writes:
>>
>>> Hello,
>>>
>>> I would like to resume our proposal from security working group.
>>> As you know, Kazu has modified the script to generate a proposal and posted the
>>minimum base system proposal, and then I created the new proposal.
>>>
>>> The difference from the original (rev01) proposal is below:
>>> 1. We remove 'duplicity', 'google-authenticator', 'pam-shield' and 'suricata' in the
>>new proposal because they have an issue such as non-well maintained, python
>>version, too much dependencies and so on. We'll separately propose them after
>>solved these issues.
>>> 2. The new proposal shows all source package as flat. Thanks to the new script,
>>Kazu!
>>> 3. Actually several packages overlap with the proposed packages for minimum
>>base system in Debian, so I added comment them like that.
>>>
>>> @kazuhiro3.hayashi at toshiba.co.jp,
>>> Would you check this proposal and set the due date to review it?
>>>
>>> Please reply if you have any comments or questions.
>>
>>I have a comment about packages in the proposal that depend on hardware /
>>system features -
>>
>>* Some packages in the proposal depend on special purpose hardware to
>>  provide their functionality. e.g., TPM.
>>
>>  In systems, where TPM is not present (or similar functionality is
>>  provided by alternate mechanisms), the TPM related packages will not
>>  be useful. e.g., the non-x86 platforms in the CIP reference hardware
>>  list.
>>
>>* Similarly, some packages require the system to be connected to the
>>  network.
>>
>>In both of these situations, I am wondering what is the impact on compliance? Is
>>there a need to also define minimal set of hardware features expected from
>>reference hardware to be able to meet compliance requirements?
>>
>
> How each reference hardware satisfies the requirements should be
> considered by each reference hardware provider.

Agreed.

But without an explicit statement of the requirement, how can a hardware
vendor wanting to develop system for CIP users know what features to
enable in their system?

> If we provide hardware mechanisms similar with TPM to protect
> credentials and authentications, we can meet compliance requirements.

TPM2 specification is more than 2000 pages long with many features and
functions. I believe the IEC standard requires a subset of this
functionality. The Security WG maybe intimately familiar with the
required features but for the reviewers on this list, there isn't any
criteria to use for evaluation.

Stating these functional requirements explicitly will serve the dual
purpose of -

* Provide an objective criteria for evaluating the package proposal (and
  discuss alternatives)

* Give hardware / system vendors the features / functions needed by CIP
  users.

What do you think?

> TPM related packages are options in only systems where TPM is
> implemented as you said. If supporting these packages require too much
> costs, the necessity of them will diminish.  Actually the standard
> lists TPM as a typical example, so we thought it will be useful to
> maintain TPM related packages for many users, but their necessities
> depend on supporting cost.

I see - thanks for the background of the TPM-related packages in the
proposal.

>
>>To help review the package list (and also discuss alternatives), it would help to
>>define the underlying functionality that is required in more detail, e.g., secure key
>>storage, verified boot, etc. It'll make it possible review the proposal more
>>concretely.

[...]
