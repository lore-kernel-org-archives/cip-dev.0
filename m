From: don.f.brown@comcast.net (Don Brown)
Date: Mon, 23 Jan 2017 07:39:38 -0500
Subject: [cip-dev] Update on Patch and mirroring KernelCI code
Message-ID: <CANm2L4nyRJ2rSE6QqWZBQ2_HqhRB7vA41ois4i85Ls6Y73WG+A@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

I like the change to the patch and I'll incorporate it tonight.

We are already mirroring the KernelCI Backend and Frontend and I had almost
the exact same thought this weekend that we already need to modify the code
to get ours working. I don't mind doing this in the short term. However,
this can be a slippery slope since we could easily get to the point where
we've essentially forked their code.

I would prefer to work with the KernelCI upstream to incorporate our
modifications into their code for the long-term.


Sincerely,

Don Brown. PMP
don.f.brown at comcast.net
Mobile: (317) 560-0513
Here's to Life, Linux and the Pursuit of Happiness

On Mon, Jan 23, 2017 at 7:00 AM, <cip-dev-request@lists.cip-project.org>
wrote:

> Send cip-dev mailing list submissions to
>         cip-dev at lists.cip-project.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.cip-project.org/mailman/listinfo/cip-dev
> or, via email, send a message with subject or body 'help' to
>         cip-dev-request at lists.cip-project.org
>
> You can reach the person managing the list at
>         cip-dev-owner at lists.cip-project.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of cip-dev digest..."
>
>
> Today's Topics:
>
>    1. Re: [PATCH] Use local copy of kernel-ci if present (Daniel Wagner)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 23 Jan 2017 10:50:28 +0100
> From: Daniel Wagner <daniel.wagner@siemens.com>
> To: cip-dev at lists.cip-project.org, Don Brown <don.f.brown@comcast.net>
> Subject: Re: [cip-dev] [PATCH] Use local copy of kernel-ci if present
> Message-ID: <4566da15-839f-e88f-f812-095d7ee770ba@siemens.com>
> Content-Type: text/plain; charset=windows-1252
>
> Hi Don,
>
> Over the weekend I had an idea to improve it even more:
>
>
> GIT_SRC="https://github.com/kernelci/kernelci-backend-config.git"
> if [ -d /vagrant/kernelci-backend-config ]; then
>     GIT_SRC=/vagrant/kernelci-backend-config
> fi
> git clone $GIT_SRC kernelci-backend
>
>
> If there is a repo available on /vagrant we clone from it. I
> think it would be even better just to copy the working
> directory instead of cloning. That would allow to hack on the
> files without committing all the time.
>
> So this would change to:
>
> if [ -d /vagrant/kernelci-backend-config ]; then
>     cp -r /vagrant/kernelci-backend-config kernelci-backend
> else
>     git clone https://github.com/kernelci/kernelci-backend-config.git
> kernelci-backend
> fi
>
> What do you think about this?
>
> And another idea I had: we should create a mirror of kernelci sources
> clone from the mirror. I am pretty sure soon we have some patches
> which need to be around to get our setup running which aren't
> available in the upstream repository. For example I had to do this here:
>
>
> --- a/roles/install-deps/tasks/install-mongodb.yml
> +++ b/roles/install-deps/tasks/install-mongodb.yml
> @@ -2,7 +2,7 @@
>
>  - name: Add MongoDB apt key (Ubuntu)
>    apt_key:  id=7F0CEB10
> -            keyserver=hkp://keyserver.ubuntu.com
> +            keyserver=hkp://keyserver.ubuntu.com:80
>    when: ansible_lsb.id == "Ubuntu"
>    tags:
>      - install
> @@ -11,7 +11,7 @@
>
>  - name: Add MongoDB apt key (Debian)
>    apt_key:  id=EA312927
> -            keyserver=hkp://keyserver.ubuntu.com
> +            keyserver=hkp://keyserver.ubuntu.com:80
>    when: ansible_lsb.id == "Debian"
>    tags:
>      - install
>
> Thanks,
> Daniel
>
>
> ------------------------------
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
>
> End of cip-dev Digest, Vol 8, Issue 11
> **************************************
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170123/7e5b30a3/attachment.html>
