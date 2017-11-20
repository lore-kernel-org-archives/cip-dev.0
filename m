From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Mon, 20 Nov 2017 08:41:13 +0000
Subject: [cip-dev] B@D Vagrant install stalls at "Setting up net-tools"
In-Reply-To: <20171119183030.7815aa8e.albert.aribaud@3adev.fr> (Albert
	ARIBAUD's message of "Sun, 19 Nov 2017 18:30:30 +0100")
References: <20171119183030.7815aa8e.albert.aribaud@3adev.fr>
Message-ID: <871skt5oly.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Albert

Thanks for this report, see inline for comments

Albert ARIBAUD <albert.aribaud@3adev.fr> writes:

> Hello all,
>
> I am trying to install B at D, building the VM  myself (method #2), on a
> Xubuntu 17.04 host.
>
> I am following the indications from
>
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdeskdingledevdeployment#b-d-deployment-method-2-building-vm-from-scratch-using-vagrant-15
>
> So I clone
> https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev
>
> Then cd into board-at-desk-single-dev and do a
>
> $ vagrant up
>
> But when the install process reaches this line:
>
> ==> default: Setting up net-tools (1.60+git20161116.90da8a0-1) ...
>
> there is no progress any more -- but no error message either.

In the sample output, at this point we have

==> default: Setting up net-tools (1.60+git20161116.90da8a0-1) ...
==> default: Reading package lists...
==> default: Building dependency tree...
==> default: Reading state information...
==> default: The following NEW packages will be installed:
==> default:   bc
==> default: 0 upgraded, 1 newly installed, 0 to remove and 1 not upgraded.
==> default: Need to get 105 kB of archives.

So in your case it doesn't progress past that first line which is
strange. As there's package installs before that. How is your machine
connected to the internet, is there a web proxy?

>
> I have checked that prerequisites for B at D are satisfied on the host.
>
> Is this stalling a known issue? Should I stick to using the prebuilt VM
> for now rather than build it myself?

I've not seen it before but using the prebuilt VM might be an easier
workaround

Robert

>
> Cordialement,
> Albert ARIBAUD
> 3ADEV
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
