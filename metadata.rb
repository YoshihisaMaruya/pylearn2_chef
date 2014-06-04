name             'pylern2'
maintainer       'Maruya Yoshihisa'
maintainer_email 'm0029.swim@gmail.com'
license          'All rights reserved'
description      'Installs/Configures pylern2'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ ubuntu }.each do |os|
    supports os
end

depends "python"
depends "apt"
depends "git"