From: angelo.compagnucci@gmail.com (Angelo Compagnucci)
Date: Thu, 9 Mar 2017 16:25:33 +0100
Subject: [cip-dev] Kernel feature support
In-Reply-To: <1489070021.2949.73.camel@codethink.co.uk>
References: <1489070021.2949.73.camel@codethink.co.uk>
Message-ID: <CA+TH9VmBs6kZ6x+j=2i_caGAVa3oHggxYH8NEtriB6ygP8H3zA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear Ben Hutchings,

2017-03-09 15:33 GMT+01:00 Ben Hutchings <ben.hutchings@codethink.co.uk>:
> We've previously agreed that not all kernel features (drivers,
> filesystems, network protocols, etc.) can be supported in an SLTS
> branch.  I'd like to start working out what the supported features
> should be for the 4.4 branch.
>
> Are members able to share their kernel .config files, showing which
> features are enabled?  Or would you prefer to specify your needs at a
> slightly higher level?

I would really like to have IIO drivers, they are generally easy to
backport and extremely useful in industrial contexts.

Sincerely, Angelo

>
> Ben.
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
>
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
