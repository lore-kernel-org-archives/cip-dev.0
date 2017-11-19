From: albert.aribaud@3adev.fr (Albert ARIBAUD)
Date: Sun, 19 Nov 2017 18:30:30 +0100
Subject: [cip-dev] B@D Vagrant install stalls at "Setting up net-tools"
Message-ID: <20171119183030.7815aa8e.albert.aribaud@3adev.fr>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

I am trying to install B at D, building the VM  myself (method #2), on a
Xubuntu 17.04 host.

I am following the indications from

https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdeskdingledevdeployment#b-d-deployment-method-2-building-vm-from-scratch-using-vagrant-15

So I clone
https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev

Then cd into board-at-desk-single-dev and do a

$ vagrant up

But when the install process reaches this line:

==> default: Setting up net-tools (1.60+git20161116.90da8a0-1) ...

there is no progress any more -- but no error message either.

I have checked that prerequisites for B at D are satisfied on the host.

Is this stalling a known issue? Should I stick to using the prebuilt VM
for now rather than build it myself?

Cordialement,
Albert ARIBAUD
3ADEV
