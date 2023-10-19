Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC55CDB465
	for <webhook@archiver.kernel.org>; Thu, 19 Oct 2023 06:27:08 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.53])
 by mx.groups.io with SMTP id smtpd.web11.21356.1697696819659957309
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Oct 2023 23:27:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Eh4LgMtp;
 spf=pass (domain: siemens.com, ip: 40.107.249.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcUh9VJaPYpWqxzN6hBymhUZbRYMAyRCaF/nstDqy4P7pbWqrEimkkTT1Aq+WF7y+Xu6cLW97qoKhJ6KIPKK4STCzRusjcUBwu6htoYMzVyAwy5+BwqkO6Rmj+nEIk5e6uYFrTIVblzBtVJVtR4DP3FGk3ySXyz7q03aXOBzdakwSi0x5FvAf2dg1ADFDyy+BELXBeWiaNK17/16aQdlKnEOav3LjEiSi91iB34bfcnjoqwt84sC3S8AbhTw2TesXWG8ATIXj2i6PkvRqnR+s9gK4U0l7DsM8e8CPhItM8yd/eUtWbj4kxUXBJD1mcEC6kVaCwILMPYyW+nKbPaIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ3JjSdPi5yVdA6ILxziYD1X41Q8ebV/Dq/ln9/fHNo=;
 b=OKQdZA1OGicp2D6XGxF2f3kKwwpX8CcMJ7eSyxveQVg+kjsYfYjwjx15945hPMU0jFlMB0E2B+bg/uAqKIsqC21Y+vN5T96HwDlbXtBOgoffq4O+a4U2Q+HeqFMtTdutjq8EK6GmQ8+Zxf/UTItUXhvEyF7Fxer51Yqs6eqWT71tmLeMXhdVHV9cwDlIA+ln+njNi80quxdq1lNFnM2AASu/G9PTQkbrD4+p3e/ovM4JbYCE+/O6uqMx3PlBMLmBqtrnIgmLrJ/eqCKBQj94puHGGhnpWo7BjiDuOTNchE4Ef2xhUST44iUbyCsaCeL9KNm/KbZA6NHrvRkwfpEDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ3JjSdPi5yVdA6ILxziYD1X41Q8ebV/Dq/ln9/fHNo=;
 b=Eh4LgMtpzxvU0yutdwdqZo4j6nXan9SI+5wJEvHzefHivbqRylqmG7PhfAVCnP39QsZLcjRwzhToys21R0flvToO7PWU24xw5YmE1WS9pzX+FrRWW2LLX/HwPZKeDZEeUm+UjgTW5fdPkuoPtUpnWrtX5HDbhxFe/bNRxnGHjRdhk6msym8sh9IHHM1Rd7jY2bF769SHV0orxagJaCFP+zYd0QLm7tf5YZv6/qgldu8X0eTERbW6YsFTwa+FhZMYM/m5Y8AfpdEdvvkmlaz4RVXzrRirm9CUea9offSweRXzL6hIJuuXfUdBOhaPemjkuFwVy8OY1F4uoeDagW7qvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 06:26:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 06:26:56 +0000
Message-ID: <e75ca86c-f07f-4c9a-8a28-ef1b0696682c@siemens.com>
Date: Thu, 19 Oct 2023 08:26:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 513c7abd-dc23-46be-335d-08dbd06c6475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HdT+C0d7aaumv4cJKPG2gymVthezdGkOyY+hj0+HrK4kHcROsoqi/07I2KbLpHemWKh2lOtl9BhsUzbwjPoUc7ebCrylWRHJZZYe6Cm1MGwaijEmfMGhYBaK1PbwxMUPwo303xGXLy7GjsdAm9bdeX9zaar7nQ/FtjcHghfxw2nftdUGkOly7OE8xIcmu1yA4gqYvO/rgLk/vGsoGpFAaBPH7OqwEe7r+wXkyi8Usi3fJMCeCf+xt72UApIdT3CiGm6hEd2kWIPpGDlsYTb+9UvteEIneOiozFD+Ezrh1keUhjsjcX6spBsqb9zJG4x7OhH4XO6PnIFO2E3RmPbQPW86km4RR6g9aFgkP/AGgH22i6jwC2Gt7+WtAf7hilamQgyvOSEPhMHVuxZW9zpcpBtx5yHnGjAt9oLWCngx6qC7SiEdzYha7BtTJPtfDWqy8O679oc6gfZ6ef1mXFENkjX6rta+ez0n43BKLKSrXyk34P7eeMQeLZoiH3OV7v8cUS1CTlGkaUbwd5cN47a6Kth3Q6VqwzejO7EEL1MlfJhMWn0/6PNnIyrfLfw/Sx0oDIv9j55SmOP6e8+0OmUioKgPjpW2bwahA/b80+Vtkh/8PYXo2yF4vmQKD0TGdW8lGGyC7x3YcA7lyHIncy3KIg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(8676002)(44832011)(86362001)(5660300002)(4001150100001)(8936002)(6506007)(31686004)(83380400001)(6512007)(36756003)(38100700002)(82960400001)(26005)(6486002)(66946007)(966005)(6916009)(66476007)(316002)(66556008)(31696002)(2906002)(478600001)(41300700001)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUdVRjZkNVM2MEF0VzVSRWVsaUJDK2xMbEcvVzFFZXN4ODRKVG1XMjF0N1k2?=
 =?utf-8?B?RFZBSjFmWTc2WUNqWURaZGdITHdWcnNKSHpBbWN6V0czUXVVTVVWS1A5TDZx?=
 =?utf-8?B?SWVlam5HSG9hSDM4U3FUdytqeHlJSG5iWlczaGl4RjhnK3R2dnpLRDBNcUFZ?=
 =?utf-8?B?MTUwZTNoKzQ4UWNQcmI3NVRsNUdrU0dqVzdiZ04vMGpBUUdmQzdNK0JBK3Ar?=
 =?utf-8?B?UmYvWGxINklKRlRUbG9FK2s1Wm9uL1ZzRFhKQmVxMVg5cXpRZmY0bmtudUpk?=
 =?utf-8?B?NWFweVVlY2NCdWUxMTArQTF1TWNrKzR0bGNSWmlCUlJPQ0JVbG1wNSt3RVBE?=
 =?utf-8?B?ckw2TjVQRjI5ckc0eVZJeW9XWkZBUUZqVUp1dGdkT1VYV1FHNFZvanFrTVN0?=
 =?utf-8?B?WGxMVTc1TVB5ajVoUGduUGRiVTdycDFHb2YzOXZuV05NbE9OdVVXMXlWa2tE?=
 =?utf-8?B?empENU9iV1JTUjd1Nk1jYmwzdUh6ZG1EbFFWUksxZW9aakpzKzRVc3FSWU8x?=
 =?utf-8?B?eXBMcXcyNytKL1FqZDBGeEtzS2hMSk5FUVlIdzg3L011VmJ2L2NZVXlVZ0lH?=
 =?utf-8?B?MlZCMitjbVZQR1JWNk9QUzkzc0dsQ29TcjVoYlZocDY4S0ZkQllxWlh6K1k1?=
 =?utf-8?B?Q0VFZ3pmVWxEUG9pQXNmVS9aeWdkdyt2K3dDV2p6WGNJTitNcnlNMUVHcSsy?=
 =?utf-8?B?cC9pMWJ6Z0t4VGRVcjVVQWJ3TTQ3WlFVUXVHVm51SWt0K1g1citGSnpzb2pz?=
 =?utf-8?B?SzQxQzRsTVBoU0UrZkk0WDA5a1M4b0lvdTF3VUpuRHVxa0pqUlZXUmZXZ3lo?=
 =?utf-8?B?UUM3TlJudjhiVUhjQTM4aHRHZXczdThwLzZSR1poRVh2YXB6T3J1cDNabGlW?=
 =?utf-8?B?RGtINlJvV1ZQdVdXc3ovUk52MXJQUHZBTldNK0djRGZWYjBlWHE3WUNIaXdZ?=
 =?utf-8?B?NG5PeTFmUVdMekRvVnkxU2J2UVZtYXNld2tkejZsQU9WbHdIM1pNT2gzNTk3?=
 =?utf-8?B?Rnc1a0k3eTFvcTEybzVCL0hLNDllczJMRmVUK0RkQUxleDFwRlRHNlNQbjl4?=
 =?utf-8?B?TzZYNWhoTlVIa1dCeVYwYVgyLzJIM2ltazhQelRoVERFMDIxeTFSL2FvQzVm?=
 =?utf-8?B?TnlOWlc3RnYrVVR5T0FuM2VXcjRlR29lV1V6Q3NNc0kxaEFXbG9yeWZDZ3do?=
 =?utf-8?B?dU94bEF3OUN0eFJTT1NZUmhBQThyLzhQZlhYSlpySGhXS0wwR3NzcStpY2xo?=
 =?utf-8?B?WElIZUdLVnJld2ZSbDIrVWl1aDVmdlFrbnZ0THhlcTZJZUw2YlRyWDNDaGRq?=
 =?utf-8?B?MC82cG10NVJGT1hhQ0tSeWdkU1VkcnFlaTVQdEpsMFVLcVZlZDFQRURtSlN6?=
 =?utf-8?B?Z0pVVytlTzVxRllEMkhWK0xqOEZRQVNJV21jOHE2ZDMxa1grZWU1MzFzY2Uv?=
 =?utf-8?B?elVPemlidHI1WW4zVEFCMWJXeDNBTWFmSXNvSHpVQVQzc3Z2K0tLcldVWkh4?=
 =?utf-8?B?aGFiMG1LbkpDVE5UMVRZWVE0cFk1RVhsOGxrTHRVTVIvSXJXeitjUHZ3TERu?=
 =?utf-8?B?dUkveG1mMktiOVBvWDNOTFFwOER1blZIRWJkRTVRYWdCSlJtS3dhMkg2Wmx5?=
 =?utf-8?B?eEZNKzZhdTN5a2UwNVhjUk52RUhCRjhLSTc1aGx6RWpNVk9CRnYvTjZqajNX?=
 =?utf-8?B?UWpORGk3SGJyU01MVUZtUmo2RGJzUS80cFBTdzhLODNuVkZidUN2Z3JaNEdP?=
 =?utf-8?B?UTNTNkJjaVJITUQxSXNWbDBiM1NFdHp1VUdRWjk1RGhaa3B1N1FUZ3pRUjJD?=
 =?utf-8?B?QUR5c2MyN2NZOUsvc3daVDU4Z3dwRWRka29sY3NUSmVaYkRzWi9OUk44OFhS?=
 =?utf-8?B?NW5WQnVrdUN6OWFWdmlVL1lhbG9iaDZyMi82M0ZONmkrQjFKOVVBYXZNb2hP?=
 =?utf-8?B?R3RCT1N5UzVvNUtPRXE3dHdyMjNTTFc1dmZUd2VzdWdHa3B6L0FDRTlKUWpj?=
 =?utf-8?B?NUg2a2lZMmxrOFpnZisyYmJMYlN2OHRISlIvY1Arb1dMbnY2YXRORXErSkVH?=
 =?utf-8?B?cnBXbFAzNGNzWnlqdElpZVkvR0VNS1huSkFVR0dja3p4azJmbzljVjl4b3lC?=
 =?utf-8?B?SGNyQ2tvWDZQL01ibWtuZXNwTElZa0plcEVPOHVUdnZPa2hEclVVN0FHcE11?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513c7abd-dc23-46be-335d-08dbd06c6475
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:26:56.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYXX/hJ2spNPOCMELiwY2pgX7sEfaJQXgEtLUxxxmeCv+78PfY0Yz9wMoAFHNhXRHc5hHgCtQ2PunmKIIJDUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5603
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Oct 2023 06:27:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13404

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=10&day=19&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/10/cip.2023-10-12-12.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

