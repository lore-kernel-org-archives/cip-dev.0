From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Thu, 08 Mar 2018 14:39:52 -0800
Subject: [cip-dev] Linux 4.4.120-cip20
In-Reply-To: <1520546738.23626.65.camel@codethink.co.uk>
References: <1520546738.23626.65.camel@codethink.co.uk>
Message-ID: <569F2972-B0A9-4503-A60A-454DD5293389@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi

On 8 March 2018 14:05:38 GMT-08:00, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
>I've released Linux version 4.4.120-cip20.??A summary of the changes
>since 4.4.112-cip18:
>
>- Merge fixes from stable versions 4.4.113-4.4.120 inclusive
>? - Includes some mitigations for Spectre v1 and v2 on x86
>- Fix stable regressions in x86/apic, arm/omap2, tca8418_keypad, leds
>- Backport additional mitigations for Spectre on x86, and related
>  fixes
>- Add SMP, I2C/IIC, RTC and SDHI support for R8A7743 and iWave board
>
>I also tagged an intermediate version 4.4.112-cip19 before merging from
>4.4-stable.
>
>(If you were expecting this last week, I apologise - I came back from
>holiday to a huge backlog of changes from 4.4-stable, and it's taken a
>lot of time to review those and to find some missing pieces.)

Just in time for ELC. Thanks for the committment.

>
>Ben.
>
>-- 
>Ben Hutchings
>Software Developer, Codethink Ltd.
>
>_______________________________________________
>cip-dev mailing list
>cip-dev at lists.cip-project.org
>https://lists.cip-project.org/mailman/listinfo/cip-dev

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
