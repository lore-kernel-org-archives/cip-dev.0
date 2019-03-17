From: nobuhiro.iwamatsu@miraclelinux.com (Nobuhiro Iwamatsu)
Date: Mon, 18 Mar 2019 08:07:03 +0900
Subject: [cip-dev] about patch review process
In-Reply-To: <4324304.6oKhBapyEa@linux-3zh6>
References: <CAGDrK-ZwHwo3f0Zakf34N+QJ+vk=z6bLebwgrjVzZHsv40UKgg@mail.gmail.com>
	<4324304.6oKhBapyEa@linux-3zh6>
Message-ID: <CAGDrK-b9OaHfMy74DpZfF2MLaqjzpZOc3HneDejPWA_k0bGi5g@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Agustin.

> I think it would be easier to use the Gitlab wiki if you want to automate the
> process since it has git in the backend and you can orchestrate the process
> through pipelines. Then I would point to the specific gitlab wiki page in the
> LF wiki.

Absolutely.
I will try to use Gitlab wiki.

Thanks,
  Nobuhiro

2019?3?14?(?) 19:02 Agustin Benito Bethencourt <agustin.benito@codethink.co.uk>:
>
> Hi,
>
> On jueves, 14 de marzo de 2019 5:35:54 (CET) Nobuhiro Iwamatsu wrote:
> > Hi, all.
> >
> > The kernel team is reviewing the stable tree patch that is the basis
> > of the CIP kernel.
> > The review results are managed on the wiki[0], but they have not been
> > updated often.
> > The kernel team discussed the issue in IRC and considered a simple process.
> >
> > I created a template with a tool[1] to create these wiki pages and
> > v4.4.176[2] patch list.
> > The review process considers the following:
> >
> > 1. A new LTS will be released.
> > 2. Create a list on wiki.
> > 3. Mark the review and the name of the worker and mark (UR: under
> > review) under the commit.
> > 4. When the review is over, update the mark.
> > 5. Work report on IRC.
> >
> > I would like to make the review active based on these. This list is
> > also maintained in the git repository[1].
> > These are classical andalso suggestions. If you have an opinion,
> > please let me know.
>
> I think it would be easier to use the Gitlab wiki if you want to automate the
> process since it has git in the backend and you can orchestrate the process
> through pipelines. Then I would point to the specific gitlab wiki page in the
> LF wiki.
>
> >
> > Best regards,
> >   Nobuhiro
> >
> > [0]:
> > https://wiki.linuxfoundation.org/civilinfrastructureplatform/linux-4.4.y
> > [1]: https://gitlab.com/cip-project/cip-kernel/lts-commit-list
> > [2]:
> > https://wiki.linuxfoundation.org/civilinfrastructureplatform/review-linux-4
> > .4.176 _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
>
>
> --
> Agust?n Benito Bethencourt
> Principal Consultant
> Codethink Ltd
> We respect your privacy.   See https://www.codethink.co.uk/privacy.html
>
>
