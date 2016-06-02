setup key-based SSH


Set secret key on remote server
http://stackoverflow.com/questions/23180650/how-to-solve-error-missing-secret-key-base-for-production-environment-on-h/26172408#26172408


Configure SELinux
http://linux.die.net/man/8/getsebool
https://wiki.apache.org/httpd/13PermissionDenied


----------

To *import* CMS fixtures: `bundle exec rake comfortable_mexican_sofa:fixtures:import FROM=bizport TO=bizport`
To *export* CMS fixtures: `bundle exec rake comfortable_mexican_sofa:fixtures:export FROM=bizport TO=bizport`

To copy CMS fixtures from remote to local: `scp -r <username>@<host>:<path/to/app/folder>/db/cms_fixtures/bizport db/cms_fixtures/`

----------

##### CMS Content Type Examples

```html
{{ cms:partial:shared/link_box:"https://paydirect.link2gov.com/LBCbuslicense/ItemSearch":"PAY":"Renewal Fee Online" }}
{{ cms:partial:shared/location_map:"SBDC: Downtown Long Beach Office":"309 Pine Ave, Long Beach, CA 90802" }}
{{ cms:partial:shared/contact_box_combo:"(562) 570-6211":"LBBIZ@longbeach.gov" }}
{{ cms:partial:shared/contact_box:"phone":"(562) 570-6105" }}
{{ cms:partial:shared/contact_box:"email":"test@example.com" }}

 <div class='callout'>
    NOTE:
  </div>
```
