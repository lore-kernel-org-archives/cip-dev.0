From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Wed, 10 May 2017 14:34:19 +0100
Subject: [cip-dev] script for health check (or any script which involves
 uploading kernel to BBB)
In-Reply-To: <87bmr0u9v5.fsf@ctlt579.codethink.co.uk>
References: <87bmr0u9v5.fsf@ctlt579.codethink.co.uk>
Message-ID: <591316DB.3070306@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 10/05/17 14:20, Robert Marshall wrote:
> The kernelci-build uploads the kernel (for a BBB build) to
>
> http://localhost:8010/cip-bbb1/cip_v4.4.27/v4.4.27/arm/omap2plus_defconfig/
>
> So that's
>
> http://localhost:8010/$TREE_NAME/$BRANCH/$TAG/$ARCH/omap2plus_defconfig/
>
> I think the ARCH can be embedded in the script (otherwise we'd need to
> embed omap2plus_defconfig too..) so we just need a script using the
> other 3 values which can then sed a base yaml file creating the
> correct urls outputting it to a new file and then running lava-tool on
> that will upload and test that kernel build to the BBB
>
> TREE_NAME can be taken from the environment variable (if it's not set -
> if for example the kernel wasn't build on this login) request the user
> to set it before running the script
>
> BRANCH and TAG can be retrieved via git commands much as build.py does
>
> So my intention is to create a script in /vagrant/scripts which is run
>
> /vagrant/scripts/create_test.sh input.yaml output.yaml which takes a
> yaml file - which could be in the release or a new one created by a B at D
> user and outputs a file (the second parameter) which can then be used in
> a lava-tool command
>
>
> Thoughts? Counter suggestions?

In phase two of the CIP testing project, we will need to sign the builds 
and provide them in a repo (or a place easily downloadable) so any 
tester can pick it up and test it, sending the report to a specific 
mailing list.

So the script will need to consider that repo as the external source for 
the build for "validation purposes".

At the same time, kernel maintainers will probably want the capability 
to create their own builds locally to be tested in their own machine, 
taking full advantage of the VM we are about to release.

Hence I believe these two scenarios will need to be considered in phase 
two. It would be good that somehow you prepare this future by 
documenting the script for this release, so it is easier to adapt it in 
the near future.

>
>
> Robert
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
