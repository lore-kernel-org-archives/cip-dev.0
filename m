From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Fri, 16 Feb 2018 10:05:22 +0100
Subject: [cip-dev] [IMPORTANT - test issue #99] Issues with installing when
 running behind a web proxy
In-Reply-To: <CAEss1E+4z6r9=UhnMxnh_Pco=i_usk3Pn05tb=q8h1t0CjV_Dg@mail.gmail.com>
References: <CAEss1E+4z6r9=UhnMxnh_Pco=i_usk3Pn05tb=q8h1t0CjV_Dg@mail.gmail.com>
Message-ID: <CAEss1EJCTM-1o9fzL1SDiqo_m8WHLBT9kvANxf27UOORzBpCvg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

More about proxies:

Here is update on the Lava proxy business. Please, read this very
carefully, since this is the solution to the problems with Lava
proxies, as well as Lava DUT ones.

YES, after applying what Remi advised to me, the qemu01 test:
https://www.validation.linaro.org/static/docs/v2/first-job.html

worked like a charm. I simply copied /etc/lava-server/env.yaml to
/etc/lava-server/env.dut.yaml (and created the new file).

Remi, I would like to thank you for the advise!

Best Regards,
Zoran Stojsavljevic

---------- Forwarded message ----------
From: Remi Duraffort <remi.duraffort@linaro.org>
Date: Thu, Feb 15, 2018 at 4:30 PM
Subject: Re: [Lava-users] [HW target questions] Pointers from Lava
test suite to the HW target
To: Zoran S <zoran.stojsavljevic.de@gmail.com>
Cc: Lava Users Mailman list <lava-users@lists.linaro.org>


Not exactly.

1/ The process that is deploying, booting and testing a DUT (Device
Under test) is called lava-run.
lava-run environment variables are controlled by /etc/lava-server/env.yaml

By default, all environment variables are removed and only a small set
of variables are added.
This helps to make executions reproducible between dispatchers and instances.

So if you need an environment variable to be set, then you have to add
it to /etc/lava-server/env.yaml

2/ On the DUT itself, by default, we don't add or change any
environment variable. Because that's the user responsibility.
However, if /etc/lava-server/env.dut.yaml does exists, it will be used
to add environment variables to the DUT shell.
To create the list of environment variables to add to the DUT, we take
the full environment from lava-run (as defined by
/etc/lava-server/env.yaml) and we apply the rules from env.dut.yaml.

I hope that does help you to understand how environment is setup in lava.

Rgds

On Wed, Feb 14, 2018 at 2:04 PM, Zoran S
<zoran.stojsavljevic.de@gmail.com> wrote:
> https://gitlab.com/cip-project/cip-testing/testing/issues/99
>
> Also from:
> https://lists.cip-project.org/pipermail/cip-dev/2017-July/000338.html
>
> At the end of test issue #99, I added the solution to this problem.
>
> Lava does NOT read VM's ENV variables. It ignores them. Lava reads
> /etc/lava-server/env.yaml as setup proxy file!
>
> Included there also /etc/lava-server/env.yaml file example.
>
> It could be done also DIRECTLY (every time bringing up the VM) using
> python, tapping into the urllib3 python code (example given):
> https://stackoverflow.com/questions/31151615/how-to-handle-proxies-in-urllib3
>
> I've tried this, using in-line python interpreter, it worked.
>
> Zoran
