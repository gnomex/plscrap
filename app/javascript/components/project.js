import React from 'react';

const Project = (props) => {
  if (!props.filtered) return null;

  return (
    <tr>
      <th scope="row">{props.name}</th>
      <td>
        <p className="">{props.description}</p>
      </td>
      <td>
        <p className="mb-0">
          <a className="btn btn-outline-danger" href={props.link} role="button">site oficial</a>
        </p>
      </td>
    </tr>
  );
}

export default Project;
