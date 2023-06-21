Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810E8EB64D7
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 08:04:05 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.111])
 by mx.groups.io with SMTP id smtpd.web10.5926.1687334635101998376
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jun 2023 01:03:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=HetzN7fp;
 spf=pass (domain: renesas.com, ip: 40.107.113.111, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0xjSsBk1G0qiDQbkjyNKbYOW2g5XSHPzKE+uBLy4qJ/u7pk6/yumOrujoyiu/QazXmkG1KW3hqHWGd1r/qrViT8BeuaXy2LkzoNH9JjJ6u8r2ZP3sr9dbLcQRvN3WlldS7MWJCC32ZNUXMrLk9sntLQm66xS2T2RODVs9gwUMviu/IBlOkOwXfbh7X+8cZUACzZYQzYi2yQAC0KCcvtFJrlO8tIxlqI7vFEAXLHJD1qJ8CKoz+nOWyhuPY/WHd1gdM1IR/2rAghjQUsYFE0BeP5kAxbjqnAZuF176Uq35zU/Ers+K1D2zj5ULOoqfhlxRXfnl4SPlunn9e/L8xhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoBlw98+h9EnlDhADrC6gmkhY9ve9PmQK6cieRuL4Io=;
 b=CRF7d6lYpFZYSHwPqcP2MqY43EXDbVqUwJl/ZDKTIkiyweHriBM7iHxQdso5lQgQeIemrnwqeRFmqJ2zRHPV9E4SKCa4i39wwPmrVRKpDix4sJZPMGnnboPPM24oUQj+IoVEjdjIU+Kr/ec7M1nXvmlxbik+moyDAiZWfdvQ2+qI25NuyphhZi0+Giw4OMgopiaf/9h5dLp7bwz6o90J2ySB6bCVnWJAIiwJkFLeRDnGKhl+YxUdv14O/uFZgRCDi96jvsKn9OI7DKWD0ipnDB6hTLjiJ+LMqBC0Apy3cYj84Op9xMK95QMZQRT7AA2roGyDjt5sw5qcW6a1k/QnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoBlw98+h9EnlDhADrC6gmkhY9ve9PmQK6cieRuL4Io=;
 b=HetzN7fp14BOlI9RtMm47yZsUIm9mjki/gjO2IihD8lKsfSol2hlCAXm8GLuANmRE5zjYg8V0HuwMUz4UB0SAJ/2GeZj1Tev+uA0H80hhxJgMKM8wTa+GxkdfOhIwfxy1CJ2hWk5rTwHxXWiqZ+o8NQ0gkEJYlEHUKbsjCT9O9o=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB9465.jpnprd01.prod.outlook.com (2603:1096:400:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 08:03:50 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 08:03:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
Subject: FW: [kernelci-members] Request for Proposals: UX Analysis 2023
Thread-Topic: [kernelci-members] Request for Proposals: UX Analysis 2023
Thread-Index: AQHZpBS6LljNijwyWEWrqTxIX+Vieq+U5UOA
Date: Wed, 21 Jun 2023 08:03:48 +0000
Message-ID: 
 <TY2PR01MB3788130CAEB273100E48CC63B75DA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <74ac6506-7171-5b78-52c5-d6a3095df9dd@collabora.com>
In-Reply-To: <74ac6506-7171-5b78-52c5-d6a3095df9dd@collabora.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB9465:EE_
x-ms-office365-filtering-correlation-id: dc912093-c65b-47c6-aa05-08db722e0b63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 t+X4hXKphGJNchGTYzVjkyZR0FMU2HE02CdD5pfk9e7azviOqGhPhXhctYIio04Qx5NytjrF8c9rH82O8f/v1n1WIszxJnfYdwxUv9DUWeBPS0/fUYSR9peWQ/8JBiZvDbO2Ed+yFlcQXc+YOY9jdX8aX+pMd4Vw/qj53OL2IK5gIoCtqnb35MoDKoBxbUM1UrZMXGh0+6ehS/r0O3ps/aAiBAVkKvcidKa3YZBsq5O32mosrDJcf6WvBiE++G3P6uQ6m+5Q6d/BbaQjl+voDCH/sjP/9ExFzeWGwDeMAjH7cUibwMgywXBmmxLXdtJLNOdhDIBP34haA1Fo7p5LhIOnI44DpJo6p+Qp85Y3pRPI5PHpbftE8B1qt5z6vTO32IvUrSc7iIqsHCfpqdurvxsi5I++7SLrWSPAV7oZ5wd2fjfv13OfQs+r/yltwkADPYamrNV21jBNPP5rpPaBYBwR68tREd3p7OVGcGNIa0aO1I+h05Vd1OCh4vBWXFZH48lPelqD5fqhjiKc+una/E4w/qOZ6OHaWXrtK7bKfnKYR33O71qG7io01Hey/V4OjuwutX3pjIoOuNVyo9KbO/ItydPrME6dKUAyP2CUpEE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(9686003)(186003)(38100700002)(122000001)(6506007)(55016003)(53546011)(26005)(66899021)(83380400001)(110136005)(76116006)(450100002)(66946007)(33656002)(478600001)(52536014)(66476007)(2906002)(5660300002)(86362001)(66556008)(316002)(66446008)(8676002)(64756008)(8936002)(41300700001)(966005)(7696005)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?1z2CdykMSlexChk8WzjBKfcwHuU5o4YdGoM+BHovC8O0FvwedTzll21m?=
 =?Windows-1252?Q?qn4DcYOwlnhIJo1trOXi+L5KSyZqvFK1RelhmXVfr2WOw0hb1NGmLNdk?=
 =?Windows-1252?Q?/texlFCNv9ayXxPWw5HTVARy5vyMqj1GM1DPjzky90XwnU9Sq37kpasg?=
 =?Windows-1252?Q?3eEDJUdne20/kAB2+Sn7mbC17dXel83La7U4FYdnuya8+BcwnGoAa9bH?=
 =?Windows-1252?Q?Ie0Vu0bYemp/ouUehw4qyYDjfCyMTtHAohtAf+9QLyf2q9f/L/CePq+5?=
 =?Windows-1252?Q?7YyfKgpQ1I8umOxGxEEAuLh1aZ3yBX0lja7BBEHIy7k0wpq6pA91Fym4?=
 =?Windows-1252?Q?nB5XC83diAbfRgMYiLJn7sEUhRRUqBO5GWNlCw9mbe6KwZlecoZ/uMRY?=
 =?Windows-1252?Q?IYvFJF+BSRvmxmjfo0b/vyDdst+rVrs+U0PIfNxoem23nXg5hoRpOSsY?=
 =?Windows-1252?Q?ttxBfApoopVCewCA1pmud+sk6WA2WAc/qzNLGQbM8PRVwFQI0sfpXdcA?=
 =?Windows-1252?Q?SpJgUrRRNmN7ft8CjYdmNJ3XlwyGgPe7Ud37Wzkle18LEDbBw3cXmtBu?=
 =?Windows-1252?Q?s8xFlnX6lDhCdqFdIf8v+xPZvQVujWIqxmtFfQs52BGG1lDyDzuK+hGz?=
 =?Windows-1252?Q?K8oWZ4KDz3vWdITqlQnM4hR0z/++qO9tTK3sFyFV3hYoF9QFwrT1p8Jb?=
 =?Windows-1252?Q?upL0FLxVCdphBkpPeQmtZl56wqsVfaUWwOHk+0xiNoU+ovj7oVZpvb6P?=
 =?Windows-1252?Q?4RXk++UXQaB7P6sN8MVwIIZ/6LVtuUZNzYPsfJBbVE1NW8UsMkA7Q3g7?=
 =?Windows-1252?Q?rCDjyMbI1Txc8+n+J/dzUjoAUHmAIOgxWWV+LrvmEgRi9HFYcq68kaje?=
 =?Windows-1252?Q?Z3TrSjG7mnZJ3OT/puSHrdGS2y78taPmt56YBJ9SgtskwBUSYMalHlLC?=
 =?Windows-1252?Q?bBwaZDS12h63SUgQtocIFA/T1XQjSeXS9wupIS1B5t3/Dbi8t2t6dwSh?=
 =?Windows-1252?Q?2gGqcjC6HzT4ZXL5czZWKB/0M+21IjaVW/jGLihSPpc6OQM/M5WW1pUu?=
 =?Windows-1252?Q?htAgtg6cPBwk/jhQDjglCwH7uOpaskaYQjFsvtU75FHNMZpytLkVTutS?=
 =?Windows-1252?Q?0TrjzkakomZ/Yy72P9IiV++GfaV+zIvrZKcURja34KYzFoQqGvh+PomO?=
 =?Windows-1252?Q?8Cdhso9SRHwzSbnhmmwZQmlPbJiDtvmiF0skBFVb+gRKgDtbi8S8mS7z?=
 =?Windows-1252?Q?yQs5eu3AfVAOd5sq7WdRyDkVHWgl2pZfVKPVesXTWJjmQrHYx1fRRazh?=
 =?Windows-1252?Q?HZr32X1yk0hHYYwmckZLvra2oS6DxCRkerObS+83f4X6/rKZRHbnl0tf?=
 =?Windows-1252?Q?rImyOLmp6y+baya0Vn5XM/7g6YJS32EN3n8+bMjqN7w53d/EReJG9/TI?=
 =?Windows-1252?Q?HGN4WFWrDbH/6Gc9oiUw/okv2it0aDuGdQogjTqJ96q7EJjA+NsdR+Kj?=
 =?Windows-1252?Q?DzH5tfbTkyjFuBkOQqLZZ3nEsgyPGDy3aNA+KGFAXyeSr/BBJJHe4mAl?=
 =?Windows-1252?Q?ISSjz7cwDNDM0O+aImoFMzSYFf9ggAPdG35wZihGUBVZXys9akqLlOP4?=
 =?Windows-1252?Q?FtyEQ7B9DVLJGwnNB7Hye7KIjur3j+9/ByJdBo+LH6D/aa23bjIm2uiP?=
 =?Windows-1252?Q?6a/jO9wvUcK+APTpiJRyjcj3GcT4dmmkboU65D7rBxOGf/qciZpuzg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc912093-c65b-47c6-aa05-08db722e0b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 08:03:48.7828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvRC2bQmW/jTc9Lq2rmJmPYE3TVDqrk7LzEjcX22I6fFbG8nT9BabJyihza/6VW/1wXHOZrl/d29y1TRRAiGtpbNbEvI+cDy6ctNotDb+rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9465
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 08:04:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12091

FYI

Kind regards, Chris

-----Original Message-----
From: kernelci-members@groups.io <kernelci-members@groups.io> On Behalf Of =
Guillaume Tucker via groups.io
Sent: Wednesday, June 21, 2023 8:49 AM
To: kernelci@lists.linux.dev; automated-testing@lists.yoctoproject.org
Cc: kernelci-members@groups.io
Subject: [kernelci-members] Request for Proposals: UX Analysis 2023

KernelCI is now looking for proposals to conduct an UX Analysis
for a new web dashboard.

Based on the Community Survey in 2020 and after gathering
feedback and ideas from kernel developers, we now have a clearer
idea of what would be expected from an ideal web dashboard for
KernelCI.  The next steps are to start thinking about how that
could be turned into reality, and for this we need some
professional help from web designers and developers as we don't
have such skills in-house.

The goal of this RFP is to go through an initial UX Analysis
phase which would then become the foundation for making
specifications to implement a real web dashboard.  The full RFP
document can be found here:

https://kernelci.org/blog/posts/2023/rfp-ux-analysis/RFP-UX-Analysis-2023-v=
2.pdf

See also the blog post which can easily be shared:

https://kernelci.org/blog/posts/2023/rfp-ux-analysis/


Please send any proposals or inquiries to the KernelCI members:

  kernelci-members@groups.io

The deadline for submitting proposals is 10th July.  However, as
we're already half-way through the initial 6-week period and we
didn't send any email about the RFP earlier, we might choose to
give it some extra time if the original deadline turns out to be
too short notice.  Please let us know if that is the case.

Best wishes,
Guillaume,
On behalf of the KernelCI board of members

