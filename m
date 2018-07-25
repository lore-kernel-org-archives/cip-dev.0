From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Wed, 25 Jul 2018 15:27:58 +0200
Subject: [cip-dev] cip-dev progress report weeks 20 - 29
In-Reply-To: <871sbrbioi.fsf@ctlt579.codethink.co.uk>
References: <871sbrbioi.fsf@ctlt579.codethink.co.uk>
Message-ID: <CAEss1E+w1ujdzO8DbkPa7Sm9v8DdUVhg2Tfyy-Pj8peBGXkNmw@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> The master of B at D now installs 2018.4 rather the latest from
>  debian-backports making the tool more resilient to upstream changes
>  and allowing us to evaluate an upstream change before it goes live.

I absolutely agree with this approach, only I would use the following
Lava release:

ii  lava-dispatcher
2018.5.post1-1+stretch      amd64                   Linaro Automated
Validation Architecture dispatcher
ii  lava-server
2018.5.post1-1+stretch      all                         Linaro
Automated Validation Architecture server

Thus making this line in the integration scripts as following:

sudo DEBIAN_FRONTEND=noninteractive apt-get -y install
lava=2018.5.post1-1+stretch -t stretch-backports

I have tested this release, and with exclusion of minor bugs it works
very fine (these bugs are also present in 2018.4).

Do NOT use Lava 2018.7 (I guess, it is a mess)!

Thank you,
Zoran
_______

On Wed, Jul 25, 2018 at 2:31 PM, Robert Marshall
<robert.marshall@codethink.co.uk> wrote:
> Hi! Here's a report on the Codethink CIP testing development over the
> past few weeks.
>
> CIP kernel testing
>
> - The master of B at D now installs 2018.4 rather the latest from
>   debian-backports making the tool more resilient to upstream changes
>   and allowing us to evaluate an upstream change before it goes live.
>
> - Also linked to the above the beaglebone black health check now uses an
>   inline test; this both breaks the reliance upon an upstream test repos
>   structure and making testing less dependent upon needing an internet connection.
>
> - Renesas board - this hardware continued to not give consistent results in B at D
>   tests so for the moment development has been suspended.
>
> - Development has started on using docker containers for B at D - the
>   kernelci one is up and kernel builds have successfully been uploaded
>   to it, there is an outstanding issue with retrieving those builds from
>   the container. Work is also being carried out on the lava docker container.
>
> Robert
> --
> Robert Marshall, Software Developer                       Codethink Ltd
> Telephone: +44 7762 840 414       3rd Floor, Dale House, 35 Dale Street
> https://www.codethink.co.uk/         MANCHESTER, M1 2HF. United Kingdom
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
