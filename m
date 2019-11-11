From: sz.lin@moxa.com (=?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Mon, 11 Nov 2019 22:43:14 +0800
Subject: [cip-dev] Build fail for linux-4.4.y-rc
In-Reply-To: <20191111134737.GA23643@amd>
References: <TYAPR01MB2285C54E0BFE44F1970EFA7DB7740@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<20191111094226.GA15737@amd> <20191111134737.GA23643@amd>
Message-ID: <CAFk6z8OBbmc1KJRD7M3vHENG+zWLqyWR7wypaSWxsRviYTQoqA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Pavel Machek <pavel@denx.de> ? 2019?11?11? ?? ??9:47???
>

<snip>

>
> This one seems to be reponsible. I have mailed author & lists...

Ack with thanks!.

After using git bisect, I confirmed that the commit id
"23160bd11f183b0e77ea54befff63e5d2607155b" caused the failure,
the previous version of kernel works fine.

The below modification in "mm/page_alloc.c" seems to be the root cause.

+       /*
+        * The number of managed pages has changed due to the initialisation
+        * so the pcpu batch and high limits needs to be updated or the limits
+        * will be artificially small.
+        */
+       for_each_populated_zone(zone)
+               zone_pcp_update(zone);
+

SZ

> .
>
> commit df82285ab4b974f2040f31dbabdd11e055a282c2
> Author: Mel Gorman <mgorman@techsingularity.net>
> Date:   Tue Nov 5 21:16:27 2019 -0800
>
>     mm, meminit: recalculate pcpu batch and high limits after init
>     completes
>
>  commit 3e8fc0075e24338b1117cdff6a79477427b8dbed upstream.
>
> Best regards,
>                                                                 Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
