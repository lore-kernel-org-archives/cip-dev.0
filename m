From: punit1.agrawal@toshiba.co.jp (Punit Agrawal)
Date: Mon, 20 Jan 2020 19:28:59 +0900
Subject: [cip-dev] RESUME REQUEST: [cip-core] Package Proposal #1
	(Security packages)
In-Reply-To: <OSAPR01MB23880B5470CDE5D534181CF5DF310@OSAPR01MB2388.jpnprd01.prod.outlook.com>
 (Kento Yoshida's message of "Fri, 17 Jan 2020 08:53:23 +0000")
References: <OSAPR01MB23880B5470CDE5D534181CF5DF310@OSAPR01MB2388.jpnprd01.prod.outlook.com>
Message-ID: <87a76ih15g.fsf@kokedama.swc.toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Yoshida-san,

Kento Yoshida <kento.yoshida.wz@renesas.com> writes:

> Hello,
>
> I would like to resume our proposal from security working group.
> As you know, Kazu has modified the script to generate a proposal and posted the minimum base system proposal, and then I created the new proposal.
>
> The difference from the original (rev01) proposal is below:
> 1. We remove 'duplicity', 'google-authenticator', 'pam-shield' and 'suricata' in the new proposal because they have an issue such as non-well maintained, python version, too much dependencies and so on. We'll separately propose them after solved these issues.
> 2. The new proposal shows all source package as flat. Thanks to the new script, Kazu!
> 3. Actually several packages overlap with the proposed packages for minimum base system in Debian, so I added comment them like that.
>
> @kazuhiro3.hayashi at toshiba.co.jp,
> Would you check this proposal and set the due date to review it?
>
> Please reply if you have any comments or questions.

I have a comment about packages in the proposal that depend on hardware
/ system features -

* Some packages in the proposal depend on special purpose hardware to
  provide their functionality. e.g., TPM.

  In systems, where TPM is not present (or similar functionality is
  provided by alternate mechanisms), the TPM related packages will not
  be useful. e.g., the non-x86 platforms in the CIP reference hardware
  list.

* Similarly, some packages require the system to be connected to the
  network.

In both of these situations, I am wondering what is the impact on
compliance? Is there a need to also define minimal set of hardware
features expected from reference hardware to be able to meet compliance
requirements?

To help review the package list (and also discuss alternatives), it
would help to define the underlying functionality that is required in
more detail, e.g., secure key storage, verified boot, etc. It'll make it
possible review the proposal more concretely.

Thoughts?

Thanks,
Punit

[...]
