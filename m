From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Tue, 28 May 2019 12:27:17 +0000
Subject: [cip-dev] [cip-core] RFC: Process to decide supported package
 list
Message-ID: <OSBPR01MB38629079C169C6162D351E82E11E0@OSBPR01MB3862.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello CIP developers,

I created a sample format[1] to decide "supported" packages.
[1] https://docs.google.com/spreadsheets/d/10b2yU5bLW8UwAw9nceidolZg7-eQQsdQhke8HEikXrI/edit#gid=0

I would like to suggest the process to decide the supported packages:
1. Everyone can suggest packages
   Select the supported level (S/A) in the column "C" and write your name to the column "D".
2. Each CIP member check if the suggested packages are required
   Put "x" if required into the column for each member (E-G in the sample sheet).
3. The packages voted by over 50% members are accepted as the supported packages

As the first step, it's better to start from the source package list installed by debootstrap. (Row 11-68)
After that, do the same process for additional packages one by one. (Row 73-)

Future plan:
May 28-31: Correct feedback and update the decision process if needed
May 31th: Feedback due date (might be delayed if the discussion has not finished)
June 3-4: Need to be approved by TSC? (e-mail?)
June 4-11: Do the STEP1 above (Target: debootstrap packages only)
June 11th: Share the result of STEP1 in the TSC meeting
           (Need to be approved by TSC to go to the next step?)
June 11-25: STEP2(Voting)
June 25th: Share the result of STEP2 in the TSC meeting
           (Need to be approved by TSC to make the final decision)

NOTE:
* Once a package is approved, its run-time & build dependencies
  must be "satisfied" in each profile (but still not supported in the levels of S/A).
* If some dependent packages are functionally required,
  they should be suggested and voted as well.

If you have any comments, please let me know.

Best regards,
Kazu

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of
> kazuhiro3.hayashi at toshiba.co.jp
> Sent: Friday, May 10, 2019 3:36 PM
> To: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] [cip-core] RFC: Process to decide supported package list
> 
> Hello CIP developers,
> 
> Thank you for your feedbacks.
> 
> Here is the simple summary of the comments from cip-dev:
> 
> ================================================
> openssl (Not in the debootstrap list)
> sudo (Not in the debootstrap list)
> 	Requested by Security WG
> 	(See also *1 below)
> 
> dash
> 	Suggested by Pavel
> 	One of the tiny packages expected on embedded system
> 
> cdebconf
> debconf
> 	Not necessary (Commented by Nobuhiro)
> 	NOTE: base-files use cdebconf's library
> 
> debian-archive-keyring
> 	Not necessary (Commented by Nobuhiro)
> 	Package maintainer's keyring
> ================================================
> 
> *1: I heared that CIP security WG will come out the essential packages list and all dependencies
>     I would like to consider the remaining packages suggested by security WG previously:
>     acl, pam, shadow / auditd / openssh / tpm2-tools
> 
> Regarding the source package list I previously attached (srcpkg_buster_amd64_debootstrap_minbase.txt),
> as Pavel pointed out (gcc-8), it's not easy to understand why each source package is added to the list.
> I've created another list of 'binary' packages including corresponding source package name
> (binpkg_buster_amd64_debootstrap_minbase.txt).
> 
> Also, the criteria for prioritizing security fixes Daniel.S proposed previously [1][2]
> should be inherited to this decision process.
> [1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/tsc-meetings/tsc_mm_jul092018#cip_core_packages
> [2] https://lists.cip-project.org/pipermail/cip-dev/2018-July/001398.html
> This discussion was concentrating on creating the 'source' package list and their priorities requested to Debian LTS.
> (Especially for security fixes)
> 
> Considering the above feedback, I would like to go ahead with the following policy:
> 
> * As the first step, focus on the source package list which binaries are installed by debootstrap minbase
>   (to simplify the discussion and clarify the decision process)
> * Use the criteria [1][2] to decide the priority of security fix supports
> * If needed, clarify functions that should be the scope (or out of scope) of the maintenance
>   (e.g. gcc-8 is listed in the debootstrap list, but libgcc, libstdc++, gcc-base are required actually)
> * Correct opinions from cip-dev about not only "packages which should be supported"
>   but also "packages which no need to support" (e.g. debian-archive-keyring in the debootstrap list)
> 
> If you have any comments, please let me know.
> 
> > 	1. Send an initial list and vote (>50% means accepted)
> > 	2. After that, each package will be voted (>50% means accepted)
> I guess it's still early for voting because the meaning of "supported"
> is still unclear among developers in cip-dev.
> (Someone requests packages that security fixes should be continuously applied to,
>  others request packages that can be just installed by cip-core generic/tiny profiles, etc.)
> It might be better to break down "support" we assuming into the several levels.
> 
> Samples of the support levels:
> 
> A.Apply security fixes immediately
>     * The package list should be sent to Debian LTS
>     * Define the package priority based on the above criteria?
> B.Fix other bugs (back-port from the upstream, fix by ourselves)
>     * Such bug fixes might not be focus of Debian LTS though required in our product development
> C.Fix development issues only when required (Normally do nothing)
>     * Build failed on CIP developers' environment
>     * The dependencies (or other functional relations) between other packages are broken
>     * etc.
> D.Available (installable) in cip-core (generic/tiny profile)
>     * Required for debugging, tracing, performance evaluation, testing, etc.
> 
> (A-C: Source codes should be shared in CIP)
> 
> Example:
> 
> SRCPKG    | LEVEL: A B C D
> ----------+---------------
> openssl   |        x x x x  Need to apply security fixes continuously
> diffutils |          x x x  Few security fixes, but want to fix functional bugs if found
> debconf   |            x x  Not necessary in products, but included in debootstrapped packages
> gdb       |              x
> 
> In my understanding, only the level "A" is the target of this discussion
> to decide the (source) package list which would be sent to Debian LTS.
> Other support levels could be discussed later when we decide other stuffs
> (e.g. which source packages should be available in the common source repository,
>  which packages should be installable in cip-core profiles, etc.)
> 
> Please give me your feedback.
> I would like to improve the above policy and my opinion about the support levels,
> then go to the next steps including the voting.
> 
> Kind regards,
> Kazu
> 
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of
> > kazuhiro3.hayashi at toshiba.co.jp
> > Sent: Tuesday, April 16, 2019 10:22 PM
> > To: cip-dev at lists.cip-project.org
> > Subject: [cip-dev] [cip-core] RFC: Process to decide supported package list
> >
> > Hello CIP developers,
> >
> > I would like to suggest an idea about the process to determine the package list that should be supported by CIP.
> > It's difficult to discuss adding any packages including their dependencies from whole Debian, mixing the two profiles.
> >
> > As the first step, it would be better to start from the source package list
> > which binary packages are installed by debootstrap minbase.
> > I attached the source package list, where only 58 packages exist.
> > I guess that it's easier to discuss which packages should be supported from such core components.
> >
> > NOTE: busybox is not included in the attached list, but it have to be supported
> > not only for the tiny profile but also initramfs (and Debian installer?) in the generic profile.
> >
> > Regarding the tiny profile, we need to keep discussion about which busybox applet should be supported.
> > I think this process should be done independently from the above discussion because
> > the all packages selected from debootstrap in the first step should be supported in the tiny profile as well.
> >
> > Regarding voting, I have the same opinion that Daniel proposed previously.
> > 	1. Send an initial list and vote (>50% means accepted)
> > 	2. After that, each package will be voted (>50% means accepted)
> >
> > As the second step, we consider adding other packages not included in the list one by one.
> > We need to decide the detailed process of the second step later.
> >
> > If you have any other opinions, please let me know.
> >
> > Kind regards,
> > Kazu
> >
> >  Kazuhiro Hayashi
> >  Corporate Software Engineering & Technology Center
> >  Toshiba Corporation
> >  Tel: +81-44-549-2476
> >  E-mail: kazuhiro3.hayashi at toshiba.co.jp
> >
