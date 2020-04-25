import React from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';

import { ProjectProvider } from './projectContext';
import Navbar from './navbar.js';
import ProjectList from './projectList.js';
import Footer from './footer.js';

const App = () => {
  return (
    <div>
      <ProjectProvider>
        <Navbar />
        <ProjectList />
      </ProjectProvider>
      <Footer />
    </div>
  );
}

export default App;
